import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CampusNavigatorPage extends StatefulWidget {
  final String assetPath;

  const CampusNavigatorPage({super.key, required this.assetPath});

  @override
  State<StatefulWidget> createState() => _CampusNavigatorPageState(assetPath);
}

class _CampusNavigatorPageState extends State<CampusNavigatorPage> {
  String assetPath = "";

  _CampusNavigatorPageState(this.assetPath);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: InAppWebView(
            initialFile: assetPath,
            initialSettings: InAppWebViewSettings(javaScriptEnabled: true),
          ),
        ), 
      );
    } else {
      final controller =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadFlutterAsset(assetPath);

      return Scaffold(
        appBar: AppBar(title: const Text("Campus Navigator")),
        body: Center(child: WebViewWidget(controller: controller)),
      );
    }
  }
}
