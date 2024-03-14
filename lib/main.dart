import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Passing Data',
      home: One(),
    ),
  );
}

class One extends StatelessWidget {
  const One({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('epub阅读器'),
        ),
        body: Center(
            child: ElevatedButton(
          child: const Text('打开一个epub文件'),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(withData: false, dialogTitle: "选择txt或者epub导入亦搜");
            if (result != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(platformFile: result.files.first.path!),
                ),
              );
            }
          },
        )));
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.platformFile});
  final String platformFile;
  @override
  State<DetailScreen> createState() => _DetailScreenState(platformFile: platformFile);
}

class _DetailScreenState extends State<DetailScreen> {
  final String platformFile;
  _DetailScreenState({required this.platformFile});

  late EpubController _epubController;

  @override
  void initState() {
    super.initState();
    _epubController = EpubController(document: EpubDocument.openFile(File(platformFile)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapterValue) => Text(
            chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.backup_sharp),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController,
        ),
      ),
      body: EpubView(
        controller: _epubController,
      ),
    );
  }
}
