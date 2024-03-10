import 'package:flutter/cupertino.dart';

class EpubItem {
  /// 封面
  String cover;

  /// 名称
  String name;

  /// 作者
  String author;

  /// 最新章节
  String chapter;

  EpubItem(
    @required this.cover,
    @required this.name,
    @required this.author,
    @required this.chapter,
  ) {}
}
