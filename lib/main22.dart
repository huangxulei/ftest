import 'dart:convert';
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
  TextEditingController textEditingController;
  TextEditingController textEditingControllerReg;
  SearchItem searchItem;
  String cover;

  @override
  void initState() {
    platformFile = widget.platformFile;
    textEditingController = TextEditingController();
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
        epubBook = await epub.EpubReader.readBook(
            File(platformFile.path).readAsBytesSync());
        textEditingController.text = epubBook.Title;
        cover = base64Encode(image.encodePng(epubBook.CoverImage));

        // searchItem = SearchItem(
        //     cover: cover,
        //     name: epubBook.Title,
        //     author: epubBook.Author,
        //     chapters: epubBook.Chapters);
      } catch (e) {
        Utils.toast("$e");
      }
    }

    setState(() {});
  }

  List<Widget> _buildList(List<epub.EpubChapter> chapters) {
    List<Widget> widgets = [];
    chapters.forEach((chapter) {
      widgets.add(_item(chapter));
    });

    return widgets;
  }

  Widget _item(epub.EpubChapter chapter) {
    var len = chapter?.SubChapters?.length;
    return ExpansionTile(
        title: Text(
          chapter?.Title,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
        children: (len > 0)
            ? chapter.SubChapters.map((subChapter) => _buildArea(subChapter))
                .toList()
            : []);
  }

  Widget _buildArea(epub.EpubChapter sub) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
          color: Colors.black12,
          alignment: Alignment.centerLeft,
          height: 40,
          margin: EdgeInsets.only(bottom: 1),
          //decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Text(sub?.Title))),
    );
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
                    SizedBox(
                      width: 10,
                    ),
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
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    SizedBox(
                      width: 20,
                    ),
                    searchItem != null
                        ? Image.memory(base64Decode(cover), width: 180)
                        : Container(child: Text("没有封面")),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          epubBook?.Title,
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person),
                            Text(epubBook?.Author)
                          ],
                        )
                      ],
                    ))
                  ])),
              Expanded(
                child: ListView(children: _buildList(searchItem?.chapters)),
              )
            ])));
  }
}

class SearchItem {
  String cover;
  String name;
  String author;
  List<epub.EpubChapter> chapters;
  SearchItem({this.cover, this.name, this.author, this.chapters}) {
    if (name == null) {
      name = "无题";
    }
    if (author == null) {
      name = "无名";
    }
  }
}
