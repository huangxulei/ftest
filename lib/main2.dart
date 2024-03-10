import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: LivePage(),
    ));

class LivePage extends StatefulWidget {
  const LivePage({Key key}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

const citys = {
  "北京": ["东城区", "西城区", "朝阳区", "丰台区", "石景山区", "顺义区", "海淀区"],
  "上海": ["东城区", "西城区", "朝阳区", "丰台区", "石景山区", "顺义区", "海淀区"],
  "广州": ["东城区", "西城区", "朝阳区", "丰台区", "石景山区", "顺义区", "海淀区"],
  "深圳": ["东城区", "西城区", "朝阳区", "丰台区", "石景山区", "顺义区", "海淀区"],
};

class _LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "列表折叠和展开",
      home: Scaffold(
        body: Container(
          child: ListView(
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    citys.keys.forEach((key) {
      widgets.add(_item(key, citys[key]));
    });

    return widgets;
  }

  Widget _item(String city, List<String> listArea) {
    return ExpansionTile(
      title: Text(
        city,
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ),
      children: listArea.map((area) => _buildArea(area)).toList(),
    );
  }

  Widget _buildArea(String area) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(area),
      ),
    );
  }
}
