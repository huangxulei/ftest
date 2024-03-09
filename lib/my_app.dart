import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.dark(),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State {
  String _base64;

  @override
  void initState() {
    super.initState();

    (() async {
      http.Response response = await http.get(
        'https://flutter.io/images/flutter-mark-square-100.png',
      );

      if (mounted) {
        setState(() {
          _base64 = BASE64.encode(response.bodyBytes);
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    if (_base64 == null) return new Container();

    Uint8List bytes = BASE64.decode(_base64);

    return new Scaffold(
      appBar: new AppBar(title: new Text('Example App')),
      body: new ListTile(
        leading: new Image.memory(bytes),
        title: new Text(_base64),
      ),
    );
  }
}
