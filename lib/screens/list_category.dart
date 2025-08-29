import 'package:flutter/material.dart';
import 'package:swigo_app/widgets/product_grid.dart';

// CategoryProductsScreen shows products for a specific category using ProductGrid.
class CategoryProductsScreen extends StatelessWidget {

  static const routName = '/CategoryProductsScreen'; 
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: Text(categoryName),
        backgroundColor: Colors.orange,
      ),
      body: ProductGrid(category: categoryName),
    );
  }
}
