import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.lable,
    this.fontSize = 20,
    this.color,
    this.maxLines,
  });
  final String lable;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: maxLines,
    );
  }
}
