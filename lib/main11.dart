import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyPaddingState(),
    ));

class MyPaddingState extends StatefulWidget {
  @override
  State<MyPaddingState> createState() => _MyState();
}

class _MyState extends State<MyPaddingState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Padding"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 20),
              child: Text("Padding"),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      "xxx",
                      style: TextStyle(backgroundColor: Colors.red),
                    ))
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red, //color
                    padding: const EdgeInsets.all(8.0), //your padding
                    child: Text("测试..."))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "xxx",
                          style: TextStyle(backgroundColor: Colors.yellow),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "xxx",
                          style: TextStyle(backgroundColor: Colors.yellow),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "xxx",
                          style: TextStyle(backgroundColor: Colors.yellow),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
