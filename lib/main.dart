import 'package:flutter/material.dart';
import './counter/counter_page.dart';
import './guess/guess_page.dart';
import './muyu/muyu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // App应用打包构建配置
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '电子木鱼',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MuyuPage(),
    );
  }
}


