import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CampusNavigatorPage extends StatelessWidget {
  final String assetPath;

  const CampusNavigatorPage({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: const Text("Campus Navigator")),
        body: InAppWebView(
          initialFile: assetPath,
          initialSettings: InAppWebViewSettings(javaScriptEnabled: true),
        ),
      );
    } else {
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadFlutterAsset(assetPath);

      return Scaffold(
        appBar: AppBar(title: const Text("Campus Navigator")),
        body: WebViewWidget(controller: controller),
      );
    }
  }
}
