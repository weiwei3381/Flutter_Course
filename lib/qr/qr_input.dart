import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/qr/qr_page.dart';
import 'package:flutter_first_station/qr/storage.dart';
import './constant.dart';

class QrInput extends StatefulWidget {
  const QrInput({super.key});

  @override
  State<QrInput> createState() => _QrInputState();
}

class _QrInputState extends State<QrInput> {
  final TextEditingController _qrTextCtrl = TextEditingController(); // 文本控制器
  final TextEditingController _qrCountCtrl =
      TextEditingController(text: DEFAULT_CHARS_NUM.toString()); // qr文字数量控制器

  @override
  void initState() {
    super.initState();
    print("初始化状态");
    Future.delayed(Duration.zero, ()=> setState(() {
      _initConfig();
    }));
  }
  // 获取配置并赋值
  void _initConfig() async{
    Map<String, dynamic> config = await SpStorage.instance.readQrConfig();
    int pageCount = config['pageCount'] ?? DEFAULT_CHARS_NUM;
    String info = config['info'] ?? '';
    _qrCountCtrl.text = pageCount.toString();
    _qrTextCtrl.text = info;
  }

  // 点击生成二维码
  void _onTapGenerateQr() {
    String info = _qrTextCtrl.text;
    // 生成二维码的默认字符数量
    int maxPageCount = int.tryParse(_qrCountCtrl.text) ?? DEFAULT_CHARS_NUM;
    // 将数据保存到存储中
    SpStorage.instance.saveQr(pageCount: maxPageCount, info: info);

    // 显示模态框
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          // 返回图像选项框
          return QrPage(
            info: info,
            maxPageCount: maxPageCount,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // 标题栏的阴影深度
        backgroundColor: Colors.white,
        // 标题栏的背景色
        title: const Text('文本转二维码'),
        // 标题文字
        // 标题文字样式
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: _qrCountCtrl,
            keyboardType: TextInputType.number, // 键盘类型：数字
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '默认为$DEFAULT_CHARS_NUM',
              label: Text('二维码最大字符数'),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _qrTextCtrl,
            maxLength: 5000,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '请输入文字内容',
            ),
            minLines: 8,
            maxLines: 12,
          ),
          Align(
            alignment: Alignment.center,
            child: MaterialButton(
              onPressed: _onTapGenerateQr,
              color: Colors.blueAccent,
              child: const Text(
                '生成二维码',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 组件销毁的方法
  @override
  void dispose(){
    _qrTextCtrl.dispose();
    _qrCountCtrl.dispose();
    super.dispose();
  }
}
