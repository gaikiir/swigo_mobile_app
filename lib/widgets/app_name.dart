import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swigo_app/widgets/title_widget.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key, this.fontSize = 26});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 28),
      baseColor: Colors.deepOrange,
      highlightColor: Colors.teal,
      child: TitleWidget(lable: 'Swigo', fontSize: fontSize),
    );
  }
}
