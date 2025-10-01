import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CampusNavigatorPage extends StatefulWidget {
  final String assetPath;
  const CampusNavigatorPage({super.key, required this.assetPath});

  @override
  State<StatefulWidget> createState() => _CampusNavigatorPageState();
}

class _CampusNavigatorPageState extends State<CampusNavigatorPage> {
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.assetPath)),
          initialSettings: InAppWebViewSettings(javaScriptEnabled: true),
          onReceivedError: (controller, request, error) {
            _showError(
              context,
              "Load error (${error.type}): ${error.description}",
            );
          },
          onReceivedHttpError: (controller, request, response) {
            _showError(
              context,
              "HTTP error (${response.statusCode}): ${response.reasonPhrase}",
            );
          },
        ),
      );
    } else {
      final controller =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(widget.assetPath));

      return Scaffold(
        appBar: AppBar(title: const Text("Campus Navigator")),
        body: WebViewWidget(controller: controller),
      );
    }
  }
}
