import 'package:flutter/material.dart';

// 主页的widget，需要传入标题文字
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // title是运行时常量，所以用final关键词修饰
  final String title;

  // 组件属性
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 组件属性，主要是计数器
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter+=10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '你点击按钮的次数为:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_box),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}