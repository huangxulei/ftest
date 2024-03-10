import 'dart:io';
import 'dart:typed_data';
import 'package:epubx/epubx.dart' as epub;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:image/image.dart' as image;

import 'utils.dart';

void main() => runApp(const OKToast(
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
  var cover, author, chapters;
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
      FilePickerResult result = await FilePicker.platform.pickFiles(withData: false, dialogTitle: "选择txt或者epub导入亦搜");
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
        epubBook = await epub.EpubReader.readBook(File(platformFile.path).readAsBytesSync());
        textEditingController.text = epubBook.Title;
        cover = epubBook.CoverImage;
        author = epubBook.Author;
        chapters = epubBook.Chapters;
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
            body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [Text('封面'), Expanded(child: cover == null ? Container(child: Text("没有封面")) : Image.memory(Uint8List.fromList(image.encodePng(cover)), width: 200, height: 200))],
                ),
              ),
              //   Expanded(
              //       child: Card(
              //           child: ListView.builder(
              //               padding: const EdgeInsets.all(8.0),
              //               itemExtent: 26,
              //               itemCount: chapters?.length,
              //               itemBuilder: (context, index) {
              //                 var curr = chapters[index];
              //                 var flag = curr.SubChapters.length > 0 ? "有${curr.SubChapters.length}" : "没有";
              //                 return SizedBox(
              //                   height: 50,
              //                   child: Column(
              //                     children: [Text("${curr?.Title.toString()} ${flag} ")],
              //                   ),
              //                 );
              //               })))
              // ])));
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: chapters?.length,
                      itemBuilder: (context, index) {
                        var curr = chapters[index];
                        var len = curr.SubChapters.length;
                        return Column(children: [
                          Text("${curr?.Title.toString()}"),
                          if (len > 0)
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: len,
                                itemBuilder: (context, index) {
                                  var ic = curr.SubChapters[index];
                                  return Text("${ic?.Title.toString()}");
                                })
                        ]);
                      }))
            ])));
  }
}
