import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:epubx/epubx.dart' as epub;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
  epub.EpubBook epubBook;
  String coverStr = "";

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
        //Utils.toast("未选择文件");
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
        epubBook = await epub.EpubReader.readBook(
            File(platformFile.path).readAsBytesSync());
        textEditingController.text = epubBook.Title;
        coverStr = base64Encode(epubBook.CoverImage.getBytes());
        // print(coverStr);
      } catch (e) {
        //Utils.toast("$e");
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
                child: coverStr != ""
                    ? Base64Image(base64string: coverStr)
                    : const Image(
                        image: AssetImage('assets/ba/懒儿1.jpg'),
                      ),
              )
            ])));
  }
}

class Base64Image extends StatelessWidget {
  final String base64string;

  const Base64Image({Key key, this.base64string}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64string);
    return Image.memory(bytes);
  }
}
