import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class _Message {
  String text;
  final bool isUser;
  bool isStreaming;

  _Message({required this.text, required this.isUser, this.isStreaming = false});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  String? _sessionId;

  Future<String> _getOrCreateSession() async {
    if (_sessionId != null) return _sessionId!;
    
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env["SARA_API"]}/chat/new-session"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _sessionId = data['session_id'];
        return _sessionId!;
      }
    } catch (e) {
      print('Failed to create session: $e');
    }
    
    // Fallback: use timestamp-based session ID
    _sessionId = "flutter_${DateTime.now().millisecondsSinceEpoch}";
    return _sessionId!;
  }

  Stream<String> streamSaraResponse(String query) async* {
    final sessionId = await _getOrCreateSession();
    final String url = "${dotenv.env["SARA_API"]}/chat/stream";
    
    final request = http.Request('POST', Uri.parse(url));
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'text/event-stream',
      'Cache-Control': 'no-cache',
    });
    request.body = jsonEncode({
      "query": query,
      "session_id": sessionId
    });

    final client = http.Client();
    try {
      final response = await client.send(request);
      
      if (response.statusCode == 200) {
        await for (final chunk in response.stream.transform(utf8.decoder)) {
          final lines = chunk.split('\n');
          for (final line in lines) {
            if (line.startsWith('data: ')) {
              try {
                final jsonStr = line.substring(6); // Remove 'data: ' prefix
                final data = jsonDecode(jsonStr);
                
                if (data['type'] == 'status' && data['message'] != null) {
                  // Handle status messages from backend (like "Reading through knowledge base...")
                  yield 'STATUS:${data['message']}';
                } else if (data['type'] == 'chunk' && data['content'] != null) {
                  yield 'CONTENT:${data['content']}';
                } else if (data['type'] == 'complete') {
                  return;
                }
              } catch (e) {
                // Skip malformed JSON
                continue;
              }
            }
          }
        }
      } else {
        // Fallback to non-streaming if streaming fails
        final fallbackUrl = "${dotenv.env["SARA_API"]}/chat/query";
        final fallbackResponse = await http.post(
          Uri.parse(fallbackUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "query": query,
            "session_id": sessionId
          }),
        );
        
        if (fallbackResponse.statusCode == 200) {
          final jsonResponse = jsonDecode(fallbackResponse.body);
          yield jsonResponse['response'] ?? 'No response available.';
        } else {
          yield 'Error: Unable to get response from SARA.';
        }
      }
    } catch (e) {
      yield 'Error: Unable to connect to SARA. Please try again.';
    } finally {
      client.close();
    }
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, _Message(text: text, isUser: true));
    });

    _controller.clear();

    // Add streaming message placeholder with dynamic status
    final streamingMessage = _Message(text: "Connecting to SARA...", isUser: false, isStreaming: true);
    setState(() {
      _messages.insert(0, streamingMessage);
    });

    String accumulatedResponse = "";
    
    try {
      await for (final chunk in streamSaraResponse(text)) {
        if (chunk.startsWith('STATUS:')) {
          // Show status message temporarily, don't accumulate
          setState(() {
            streamingMessage.text = chunk.substring(7);
          });
        } else if (chunk.startsWith('CONTENT:')) {
          // Accumulate actual content
          accumulatedResponse += chunk.substring(8);
          setState(() {
            streamingMessage.text = accumulatedResponse;
          });
        }
      }
      
      // Mark streaming as complete
      setState(() {
        streamingMessage.isStreaming = false;
      });
    } catch (e) {
      setState(() {
        streamingMessage.text = "Error: Unable to get response. Please try again.";
        streamingMessage.isStreaming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Sara"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 5, 5, 5),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Newest at bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color:
                          msg.isUser ? Colors.blueAccent : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        msg.isUser
                          ? Text(
                              msg.text,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : MarkdownBody(
                              data: msg.text,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(color: Colors.black87),
                                a: TextStyle(color: Colors.blue),
                              ),
                              onTapLink: (text, href, title) async {
                                if (href != null) {
                                  final uri = Uri.parse(href);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                                  }
                                }
                              },
                            ),
                        if (msg.isStreaming && !msg.isUser)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Typing...",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.white, //const Color.fromARGB(255, 22, 6, 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: _sendMessage,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Type your query...",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _sendMessage(_controller.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
