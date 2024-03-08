import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MaterialApp(home: SimpleApp()));

class SimpleApp extends StatelessWidget {
  const SimpleApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Demo')),
      body: ChangeNotifierProvider(
        lazy: true,
        create: (BuildContext context) => NotifierCounter(), //方法
        child: const ProvidersDemo(), //布局
      ),
    );
  }
}

class NotifierCounter with ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    _notification();
  }

  void decrement() {
    count--;
    _notification();
  }

  void _notification() {
    notifyListeners();
  }
}

class ProvidersDemo extends StatelessWidget {
  const ProvidersDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Counter',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
        Consumer(
          builder: (BuildContext context, NotifierCounter counter, child) {
            return Text('${counter.count}',
                style: const TextStyle(fontSize: 45));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () => context.read<NotifierCounter>().increment(),
                label: const Text('increment'),
                icon: const Icon(Icons.add)),
            TextButton.icon(
                onPressed: () => context.read<NotifierCounter>().decrement(),
                label: const Text('decrement'),
                icon: const Icon(Icons.remove))
          ],
        )
      ]),
    );
  }
}
