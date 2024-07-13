import 'package:flutter/material.dart';

// 敲击木鱼产生的数字
class AnimateText extends StatefulWidget {
  final String text;

  const AnimateText({Key? key, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FadTextState();
}

class _FadTextState extends State<AnimateText>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;  // 透明度变化量
  late Animation<double> scale;  // 大小变化量
  late Animation<Offset> position;  // 位置变化量

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
        position: position,
        child: FadeTransition(opacity: opacity, child: Text(widget.text)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器,默认是从0到1, 并设定动画的时长
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    // 由于透明度需要从0到1,所以重新初始化补间动画,从1到0,并赋予动画控制器
    opacity = Tween(begin: 1.0, end: 0.0).animate(controller);
    // 功德值的文字大小由大变小, 从1.0变到0.8
    scale = Tween(begin: 1.0, end: 0.8).animate(controller);
    // 移动变化传入 position 动画器，泛型为 Offset，从 Offset(0, 2) ~ Offset.zero 变化，
    // 对应的效果就是：在竖直方向上的偏移量，从两倍子组件高度变化到 0
    position = Tween<Offset>(begin: const Offset(0,2), end: Offset.zero).animate(controller);
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.forward(from: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
