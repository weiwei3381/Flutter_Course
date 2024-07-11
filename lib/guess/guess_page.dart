import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './result_notice.dart';
import './guess_app_bar.dart';
import 'dart:math';

import 'package:flutter/services.dart';

// 主页的widget，需要传入标题文字
class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  // title是运行时常量，所以用final关键词修饰
  final String title;

  // 组件属性
  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  bool _guessing = false; // 是否在猜数字的过程中
  final Random _random = Random(); // 获得随机数种子
  int _value = 0; // 组件属性，主要是猜数字对应的值
  bool? _isBig; // 判断值是大是小
  final TextEditingController _guessCtrl = TextEditingController(); // 文本控制器

  // 产生随机值
  void _generateRandomValue() {
    setState(() {
      _value = _random.nextInt(100);
      _guessing = true; // 猜测正式开始
    });
  }

  // 检测目标值状态
  void _onCheck() {
    int? guessValue = int.tryParse(_guessCtrl.text);  // 用户猜测的值
    // 游戏没有开始或者输入的不是整数，则直接返回
    if (!_guessing || guessValue == null) return;
    if (guessValue == _value) {
      // 设置实例的值
      setState(() {
        _isBig = null;
        _guessing = false;
      });
      return;
    }

    // 猜错了
    setState(() {
      _isBig = guessValue > _value;
    });
  }

  // 销毁流程，把输入控制器销毁
  @override
  void dispose() {
    _guessCtrl.dispose();
    super.dispose();
  }

  // 界面显示组件
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 头部标题栏
      appBar: GuessAppBar(
        onCheck: _onCheck,
        controller: _guessCtrl,
      ),
      // 主体内容
      body: Stack(
        children: [
          if (_isBig != null)
            Column(children: [
              if (_isBig!) ResultNotice(color: Colors.redAccent, info: '大了'),
              const Spacer(),
              if (!_isBig!) ResultNotice(color: Colors.blueAccent, info: '小了'),
            ]),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing)
                  const Text(
                    '点击生成随机数值',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                Text(
                  _guessing ? '**' : '$_value',
                  style: const TextStyle(
                      fontSize: 68, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
      // 浮动按钮
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.yellow,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }
}
