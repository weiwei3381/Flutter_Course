import 'package:flutter/material.dart';
import 'package:flutter_first_station/qr/qr_input.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      title: '我的二维码',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, //用于提供通用部件（Widgets）的本地化支持
        GlobalCupertinoLocalizations.delegate, //用于提供Cupertino风格的组件的本地化支持
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),// 支持的语言和地区
      ],
      home: const QrInput(),
    );
  }
}
