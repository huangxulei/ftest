import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

BoxDecoration globalDecoration;

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    globalDecoration = const BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(image: AssetImage("assets/ba/懒儿1.jpg")));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 800,
      height: 800,
      decoration: globalDecoration,
    ));
  }
}
