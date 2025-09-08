//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlViewerMobile extends StatefulWidget {
  final String assetPath;
  const HtmlViewerMobile({super.key, required this.assetPath});

  @override
  State<HtmlViewerMobile> createState() => _HtmlViewerMobileState();
}

class _HtmlViewerMobileState extends State<HtmlViewerMobile> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}