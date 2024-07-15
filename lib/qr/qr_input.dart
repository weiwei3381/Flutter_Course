import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/qr/qr_page.dart';

class QrInput extends StatefulWidget {
  const QrInput({super.key});

  @override
  State<QrInput> createState() => _QrInputState();
}

class _QrInputState extends State<QrInput> {
  final TextEditingController _qrTextCtrl = TextEditingController(); // 文本控制器
  final TextEditingController _qrCountCtrl =
      TextEditingController(); // qr文字数量控制器

  // 点击生成二维码
  void _onTapGenerateQr() {
    // 显示模态框
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          // 返回图像选项框
          return QrPage(
            info: _qrTextCtrl.text,
            maxPageCount: int.tryParse(_qrCountCtrl.text) ?? 100,
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
        title: const Text('文本'),
        // 标题文字
        // 标题文字样式
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: _qrCountCtrl,
            keyboardType: TextInputType.number, // 键盘类型：数字
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '默认为150',
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
            maxLines: 14,
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
}
