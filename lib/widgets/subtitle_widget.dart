import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.label,
    this.fontWeight = FontWeight.w400,
    this.textDecoration = TextDecoration.none,
    this.fontSize = 18,
    this.color,
    this.fontStyle = FontStyle.normal,
  });

  final String label;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final Color? color;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight,
        decoration: textDecoration,
        fontSize: fontSize,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        fontStyle: fontStyle,
      ),
    );
  }
}
