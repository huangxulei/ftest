import 'dart:io';
import 'package:epubx/epubx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'utils.dart';

void main() => runApp(OKToast(
        child: MaterialApp(
      home: MyApp(),
    )));

class MyApp extends StatefulWidget {
  final PlatformFile platformFile;
  const MyApp({Key key, this.platformFile}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PlatformFile platformFile;
  EpubBook epubBook;
  TextEditingController textEditingController;
  TextEditingController textEditingControllerReg;

  @override
  void initState() {
    platformFile = widget.platformFile;
    textEditingController = TextEditingController();
    textEditingControllerReg = TextEditingController();
    init();
    super.initState();
  }

  init() async {
    if (platformFile == null) {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(withData: false, dialogTitle: "选择txt或者epub导入亦搜");
      if (result == null) {
        Utils.toast("未选择文件");
        if (platformFile == null) {
          Navigator.of(context).pop();
          return;
        }
      } else {
        platformFile = result.files.first;
      }
    }

    if (platformFile.extension == "epub") {
      try {
        epubBook = await EpubReader.readBook(
            File(platformFile.path).readAsBytesSync());
        textEditingController.text = epubBook.Title;
      } catch (e) {
        Utils.toast("$e");
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text("导入本地txt或epub"),
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('书名'),
                    Expanded(
                        child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        //searchItem.name = value;
                      },
                    ))
                  ],
                ),
              ),
              Expanded(
                child:,
              )
            ])));
  }
}
