import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  double _progessStatus = 0;
  StreamSubscription<double> _onProgressChanged;

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _progessStatus = progress;
        });
      }
    });
  }

  @override
  void dispose() {
    _onProgressChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xff9c0303),
          appBar: AppBar(
            title: Text("Deracoin"),
            backgroundColor: Color(0xff9c0303),
          ),
          body: Center(
            child: WebviewScaffold(
              url: "https://deracoin.com/login",
              withZoom: false,
              withLocalStorage: true,
              hidden: true,
              scrollBar: false,
            ),
          )),
    );
  }
}
