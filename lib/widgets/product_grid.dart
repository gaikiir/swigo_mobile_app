import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swigo_app/models/product_model.dart';
import 'package:swigo_app/provider/product_manager_provider.dart';
import 'package:swigo_app/services/app_manager.dart';
import 'package:swigo_app/widgets/empty_widget.dart';
import 'package:swigo_app/widgets/product_widget.dart';


// ProductGrid displays a responsive grid of products, filtered by category or search.
// Uses MediaQuery for screen sizing to enable dynamic adjustments.
class ProductGrid extends StatelessWidget {
  final String? category; // Category filter (exact match) or 'All'
  final String? searchQuery;

  const ProductGrid({super.key, this.category, this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final products = _getFilteredProducts(provider);

        if (products.isEmpty) {
          return const Center(
            child: EmptyWidget(
              imagePath: AssetManager.emptyBag,
              title: 'Whoops',
              subtitle:
                  "There's No item found! Please Try to search \n for the correct item",
              buttonText: 'GO SHOP NOW',
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.maxWidth / 180).floor().clamp(2, 5);
            
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => ProductWidget(product: products[index]),
            );
          },
        );
      },
    );
  }

  // Internal filter method; combines category and search.
  List<ProductModel> _getFilteredProducts(ProductProvider provider) {
    List<ProductModel> products = provider.getProducts;

    if (category != null && category != 'All') {
      products = products
          .where((p) => p.category.toLowerCase() == category!.toLowerCase())
          .toList();
    }

    if (searchQuery != null && searchQuery!.trim().isNotEmpty) {
      final q = searchQuery!.trim().toLowerCase();
      products = products.where((p) {
        return p.productName.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q);
      }).toList();
    }

    return products;
  }
}
