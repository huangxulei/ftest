import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Tab> _myTabs = <Tab>[
    const Tab(
      text: '选项一',
      icon: Icon(Icons.add_shopping_cart),
    ),
    const Tab(
      text: '选项二',
      icon: Icon(Icons.wifi_tethering),
    ),
    const Tab(
      text: '选项三',
      icon: Icon(Icons.airline_seat_flat_angled),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TabBar Demo',
      home: Scaffold(
        body: DefaultTabController(
            length: _myTabs.length, //tabs数量
            initialIndex: 1, //默认下标 显示那个
            child: Scaffold(
              appBar: AppBar(
                title: Text('TabBar Demo'),
                leading: const Icon(Icons.menu),
                actions: <Widget>[Icon(Icons.search)],
                bottom: TabBar(
                  tabs: _myTabs,
                  indicatorColor: Colors.black,
                  indicatorWeight: 5,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.limeAccent,
                  unselectedLabelColor: Colors.deepOrange,
                ),
              ),
              body: TabBarView(
                //内容页面
                children: _myTabs.map((Tab tab) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[const Icon(Icons.tab), Text(tab.text)],
                    ),
                  );
                }).toList(),
              ),
            )),
      ),
    );
  }
}
