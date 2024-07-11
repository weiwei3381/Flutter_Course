import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget {
  final Color color;
  final String info;

  // 构造有状态组件情况
  const ResultNotice({Key?key, required this.color, required this.info});

  @override
  State<ResultNotice> createState() => _ResultNoticeState();
}

// 有状态组件的状态类，这个才是关键
// 能够在内部通过widget可以拿到实例
class _ResultNoticeState extends State<ResultNotice>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  // 创建带状态组件的初始化生命周期
  @override
  void initState() {
    super.initState();
    // 创建动画控制器对象，动画控制器的值会在指定时长内，从 0 匀速变化到 1
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    controller.forward();
  }

  // 组件更新的生命周期，确保每次哪怕碰到一样的“大了”或者“小了”都有动画效果
  @override
  void didUpdateWidget(covariant ResultNotice oldWidget) {
    controller.forward(from: 0);
    super.didUpdateWidget(oldWidget);
  }

  // 组件销毁的生命周期
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  // 组件执行的生命周期
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          alignment: Alignment.center,
          color: widget.color,
          child: AnimatedBuilder(
              animation: controller,
              builder: (_, child)=> Text(widget.info,style: TextStyle(
                  fontSize: 54 * (controller.value), color: Colors.white, fontWeight: FontWeight.bold))
          ),
        ));
  }
}
