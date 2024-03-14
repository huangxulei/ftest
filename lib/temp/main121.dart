import 'package:flutter/material.dart';

void main() {
  runApp(const ValueListenablePage());
}

class ValueListenablePage extends StatefulWidget {
  const ValueListenablePage({super.key});

  @override
  State<ValueListenablePage> createState() => _ValueListenablePageState();
}

class _ValueListenablePageState extends State<ValueListenablePage> {
  final isShowNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  void show() {
    isShowNotifier.value = true;
  }

  void hide() {
    isShowNotifier.value = false;
  }

  @override
  void dispose() {
    isShowNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenablePage'),
      ),
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 50,
              child: buildValueListenable(context),
            ),
            Positioned(
              top: 200,
              child: buildButton(context),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildHide(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Text(
        "当前隐藏",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget buildValueListenable(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isShowNotifier,
      builder: (BuildContext aContext, bool isShow, Widget? child) {
        if (isShow) {
          return child ?? buildHide(context);
        } else {
          return buildHide(context);
        }
      },
      child: Container(
        color: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: const Text(
          "ValueListenableBuilder Child",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
      width: 300,
      height: 220,
      color: Colors.deepOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              show();
            },
            child: Container(
              height: 50,
              width: 200,
              color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Text(
                '点击显示',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              hide();
            },
            child: Container(
              height: 50,
              width: 200,
              color: Colors.lightBlue,
              alignment: Alignment.center,
              child: Text(
                '点击隐藏',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
