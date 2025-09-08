import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HtmlViewerWeb extends StatelessWidget {
  final String assetPath;
  const HtmlViewerWeb({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialFile: assetPath,
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
          ),
          onWebViewCreated: (controller) {
            // Example: handle "back to menu" messages from JS
            controller.addJavaScriptHandler(
              handlerName: 'goBackToMenu',
              callback: (args) {
                Navigator.pop(context);
                return null;
              },
            );
          },
        ),
      ),
    );
  }
}
