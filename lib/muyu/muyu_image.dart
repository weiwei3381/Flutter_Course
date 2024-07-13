import 'dart:math';
import 'package:flutter/material.dart';

class MuyuAssetsImage extends StatelessWidget{
  final String image;
  final VoidCallback onTap;

  const MuyuAssetsImage({
    super.key,
    required this.image,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(  // 使用GestureDetector组件监听点击回调
          onTap: onTap,
          child: Image.asset(
            image,
            height: 180,
          ),
        )
    );
  }

}