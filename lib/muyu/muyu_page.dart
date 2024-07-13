import 'dart:math';
import 'dart:ui';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/muyu/animate_text.dart';
import 'package:flutter_first_station/muyu/models/image_option.dart';
import 'package:flutter_first_station/muyu/muyu_image.dart';
import 'package:flutter_first_station/muyu/options/select_image.dart';
import './count_panel.dart';

// 敲木鱼的主页面
class MuyuPage extends StatefulWidget {
  const MuyuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MuyuPageState();
}

// 敲木鱼的状态类
class _MuyuPageState extends State<MuyuPage> {
  void _toHistory() {}

  void _onTapSwitchAudio() {}

  int _count = 0; // 当前的功德数
  int _curValue = 0; // 每次新增的值
  final Random _random = Random(); // 随机数种子
  AudioPool? pool; // 音频资源池
  final List<ImageOption> imageOptions = const [
    ImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    ImageOption('尊享版', 'assets/images/muyu_2.png', 3, 6),
  ];
  int _activeImageIndex = 0; // 激活的木鱼图片索引
  // 激活的图像
  String get activeImage => imageOptions[_activeImageIndex].src;

  // 敲击时增加的数值
  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  // 点击敲击木鱼
  void _onKnock() {
    pool?.start(); // 播放音频资源
    setState(() {
      _curValue = knockValue; // 使用激活的木鱼随机功德值
      _count += _curValue;
    });
  }

  void _onSelectImage(int value) {
    Navigator.of(context).pop(); // 确保选择时关闭底部弹框
    if (value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
    });
  }

  // 点击切换图片
  void _onTapSwitchImage() {
    // 显示模态框
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return ImageOptionPanel(
              imageOptions: imageOptions,
              onSelect: _onSelectImage,
              activeIndex: _activeImageIndex);
        });
  }

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  // 初始化音频资源信息
  void _initAudioPool() async {
    pool = await FlameAudio.createPool('muyu_2.mp3', maxPlayers: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // 标题栏的阴影深度
        backgroundColor: Colors.white,
        // 标题栏的背景色
        title: const Text('电子木鱼'),
        // 标题文字
        // 标题文字样式
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
        // 标题栏的图标主题
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: CountPanel(
                  count: _count,
                  onTapSwitchAudio: _onTapSwitchAudio,
                  onTapSwitchImage: _onTapSwitchImage)),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (_curValue > 0) AnimateText(text: '功德+$_curValue'),
                MuyuAssetsImage(
                  image: activeImage,
                  onTap: _onKnock,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
