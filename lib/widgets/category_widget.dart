import 'package:flutter/material.dart';

// CategoryWidget displays a category icon and name; tappable for navigation.
class CategoryWidget extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const CategoryWidget({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              height: 56,
              width: 56,
              fit: BoxFit.cover, // Changed to cover to avoid distortion.
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.category, size: 56),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
