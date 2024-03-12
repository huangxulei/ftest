import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp()); //default image
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Container());
  }
}

void _getImageBase64() async {
  http.Response response = await http.get(Uri.parse(
      'https://protocoderspoint.com/wp-content/uploads/2022/09/Whats-New-in-Flutter-3.3-696x392.jpg'));

  var _base64 = base64Encode(response.bodyBytes);
  print(_base64);
}
