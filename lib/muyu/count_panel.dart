import 'package:flutter/material.dart';

class CountPanel extends StatelessWidget {
  final int count;
  final VoidCallback onTapSwitchAudio;
  final VoidCallback onTapSwitchImage;

  const CountPanel({
    super.key,
    required this.count,
    required this.onTapSwitchAudio,
    required this.onTapSwitchImage
  });

  @override
  Widget build(BuildContext context) {
    // 按钮样式
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(36, 36), // 最小尺寸
      padding: EdgeInsets.zero, // 边距
      backgroundColor: Colors.green,
      elevation: 0,
    );

    return Stack(
      children: [
        Center(
            child: Text(
              '功德数：$count',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
        Positioned(
            right: 10,
            top: 10,
            child: Wrap(
              spacing: 4,
              direction: Axis.vertical,
              children: [
                ElevatedButton(
                  child: Icon((Icons.music_note_outlined)),
                  style: style,
                  onPressed: onTapSwitchAudio,
                ),
                ElevatedButton(
                  child: Icon((Icons.image)),
                  style: style,
                  onPressed: onTapSwitchImage,
                )
              ],
            ))
      ],
    );
  }}