import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:card_swiper/card_swiper.dart';

class QrPage extends StatefulWidget {
  final String info;
  final int maxPageCount;

  const QrPage({Key? key, required this.info, required this.maxPageCount})
      : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  int get pageCount {
    int length = widget.info.length; // 信息的长度
    int pageCount = widget.maxPageCount ?? 150; // 每页二维码显示的文字数量
    int pageNum = length ~/ pageCount; // 一共生成的页数
    return pageNum + 1;
  }

  List<String> get splitInfos {
    List<String> splitInfos = []; // 最后生成的信息
    int length = widget.info.length; // 信息的长度

    int pageMaxCount = widget.maxPageCount ?? 100; // 用户希望每页二维码最多显示的文字数量
    int pageNum = length % pageMaxCount == 0
        ? (length ~/ pageMaxCount)
        : (length ~/ pageMaxCount) + 1; // 一共生成的页数
    int pageCount = (length / pageNum).ceil(); // 实际每页的字符数量
    for (int i = 0; i < pageNum; i++) {
      // 如果不是最后一个,则每个按字符数量进行
      if (i < pageNum - 1) {
        String value =
            widget.info.substring(i * pageCount, (i + 1) * pageCount);
        splitInfos.add(value);
      }
      // 最后一个则直接取到剩余的字符
      if (i == pageNum - 1) {
        String lastValue = widget.info.substring(i * pageCount);
        splitInfos.add(lastValue);
      }
    }
    print('splitInfos: $splitInfos, 长度:${splitInfos.length}');
    return splitInfos;
  }

  Widget _buildQrImageByIndex(int index) {
    return Column(children: [
      const SizedBox(height: 10),
      QrImageView(
        data: splitInfos[index],
        version: QrVersions.auto,
        padding: const EdgeInsets.all(15.0),
      )
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // 标题栏的阴影深度
        backgroundColor: Colors.white,
        // 标题栏的背景色
        title: const Text('我的二维码'),
        // 标题文字
        // 标题文字样式
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
        // 标题栏的图标主题
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history))
        ],
      ),
      body:
        Swiper(
          itemBuilder: (BuildContext context, int index) {
            return _buildQrImageByIndex(index);
          },
          itemCount: splitInfos.length,
          pagination: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
                return Column(
                  children: [
                    const Expanded(child: Spacer()),
                    const Expanded(child: Spacer()),
                    const Expanded(child: Spacer()),
                    Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '第${config.activeIndex + 1}页/共${config.itemCount}页',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ))
                  ],
                );
              }),
          loop: false,
        )
    );
  }
}
