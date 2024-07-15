import 'package:flutter/material.dart';
import 'package:flutter_first_station/muyu/models/image_option.dart';

class ImageOptionPanel extends StatelessWidget {
  final List<ImageOption> imageOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const ImageOptionPanel({Key? key,
    required this.imageOptions,
    required this.onSelect,
    required this.activeIndex})
      : super(key: key);

  Widget _buildByIndex(int index){
    bool active = index == activeIndex;  // 激活的状态
    print(active);
    // 图片上的动作检测
    return GestureDetector(
      onTap: ()=> onSelect(index),
      child: ImageOptionItem(
        option: imageOptions[index],
        active: active,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold);  // 选择木鱼4个字的样式
    const EdgeInsets padding = EdgeInsets.symmetric(
        horizontal: 8.0, vertical: 16);

    return Material(child: SizedBox(
      height: 250,
      child: Column(children: [
        Container(height: 46,
          alignment: Alignment.center,
          child: const Text('选择木鱼', style: labelStyle,)),
        Expanded(child: Padding(
          padding: padding,
          child: Row(
            children: [
              Expanded(child: _buildByIndex(0)),
              SizedBox(width: 10),
              Expanded(child: _buildByIndex(1))
            ],
          ),
        ))
      ],),
    ),);
  }
}

// 单个木鱼的选项显示
class ImageOptionItem extends StatelessWidget {
  final ImageOption option;
  final bool active;  // 如果激活的木鱼,则显示蓝色框

  const ImageOptionItem({Key? key, required this.option, required this.active});

  @override
  Widget build(BuildContext context) {
    print(active);
    Border activeBorder =
    Border.fromBorderSide(BorderSide(color: Colors.blue));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: !active ? null : activeBorder,
      ),
      child: Column(
        children: [
          Text(option.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(option.src),
              )),
          Text('每次功德 +${option.min}~${option.max}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
