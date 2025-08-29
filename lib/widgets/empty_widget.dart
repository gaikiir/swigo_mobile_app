import 'package:flutter/material.dart';
import 'package:swigo_app/widgets/subtitle_widget.dart';
import 'package:swigo_app/widgets/title_widget.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });
  final String imagePath, title, subtitle, buttonText;
  //clear the search field
  //final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 30),
          Image.asset(
            imagePath,
            height: size.height * 0.38,
            width: double.infinity,
          ),
          const SizedBox(height: 20),
          TitleWidget(lable: 'Whoops!', color: Colors.red),
          SubtitleWidget(
            label: title,
            color: Colors.black12,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 20),
          SubtitleWidget(
            label: subtitle,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            onPressed: () {},
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
