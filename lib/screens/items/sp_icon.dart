import 'package:flutter/material.dart';

class SPIcon extends StatelessWidget {
  final String assetName;
  final int? index;
  final int? currentIndex;
  const SPIcon(
      {Key? key, required this.assetName, this.index, this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/${assetName}",
      height: 25,
      width: 25,
      color: index == currentIndex ? const Color(0xFF2C53B1) : Colors.grey,
    );
  }
}
