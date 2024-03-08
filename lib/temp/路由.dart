import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: FirstPage(),
    ));

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SecondPage();
          }));
        },
        child: Image.network(
          'http://www.flydean.com/wp-content/uploads/2019/06/cropped-head5.jpg',
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            'https://img-blog.csdnimg.cn/bb5b19255ab6406cb6bdc467ecc40462.webp',
          ),
        ),
      ),
    );
  }
}
