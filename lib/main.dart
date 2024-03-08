import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: RoutePageA(),
    ));

class RoutePageA extends StatelessWidget {
  const RoutePageA({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('RoutePageA'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RoutePageB();
            }));
          },
          child: Text('跳转到下一个界面RoutePageB'),
        ),
      ),
    );
  }
}

class RoutePageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('RoutePageB'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('回到上一个界面'),
        ),
      ),
    );
  }
}
