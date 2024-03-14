import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FMMaterialAppVC());
}

class FMMaterialAppVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AAA(),
      ),
      routes: {
        '/bbb': (context) => BBB(),
      },
    );
  }
}

class AAA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AAA'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('选择一个文件'),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(withData: false, dialogTitle: "选择txt或者epub导入亦搜");
            if (result != null) {
              Navigator.pushNamed(context, '/bbb', arguments: result);
            } else {
              print('你没有打开一个文件');
            }
          },
        ),
      ),
    );
  }
}

class BBB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String message = ModalRoute.of(context).settings.arguments as String;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('BBB'),
      ),
      body: Center(
        child: TextButton(
          child: Text('点击前往CCC'),
          onPressed: () {
            Navigator.pushNamed(context, '/ccc');
          },
        ),
      ),
    );
  }
}

class DDD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('DDD'),
      ),
      body: Center(
        child: TextButton(
          child: Text('点击回到AAA'),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }
}
