import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static String routeName = "/webviewscreen";

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    if(Platform.isAndroid){
      WebView.platform = AndroidWebView();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context)!.settings.arguments as String;
    return WebView(
      initialUrl: "whatsapp://send?phone=+6282210101588",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
