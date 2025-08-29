import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swigo_app/models/product_model.dart';
import 'package:swigo_app/provider/product_manager_provider.dart';
import 'package:swigo_app/screens/category_display.dart';
import 'package:swigo_app/screens/inner_screen/promotion.dart';
import 'package:swigo_app/screens/list_category.dart';
import 'package:swigo_app/services/app_manager.dart';
import 'package:swigo_app/widgets/app_name.dart';
import 'package:swigo_app/widgets/category_widget.dart';
import 'package:swigo_app/widgets/subtitle_widget.dart';

// HomeScreen is the main entry point, displaying categories, banners, and popular products.
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const CategoriesSection(),
              const SizedBox(height: 16),
              const SwiperScreen(), // Assuming this is your banner widget.
              const SizedBox(height: 24),
              const PopularSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom AppBar for home screen.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      toolbarHeight: 80,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(AssetManager.shoppingBag),
      ),
      title: const AppNameWidget(fontSize: 26),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 24),
            onPressed: () {}, // Add notification logic.
          ),
        ),
      ],
    );
  }
}

// Categories section with header and limited grid.
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SubtitleWidget(label: 'Categories'),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CategoryScreen.routeName),
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        const HomeCategoriesGrid(),
      ],
    );
  }
}

// Responsive grid for home categories (limited to 8).
class HomeCategoriesGrid extends StatelessWidget {
  const HomeCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = (width / 100).floor().clamp(
          4,
          8,
        ); // Responsive: min 4 columns.

        return Consumer<ProductProvider>(
          builder: (context, provider, child) {
            final categories = provider.getCategories
                .take(8)
                .toList(); // Limit to 8.
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return CategoryWidget(
                  name: cat.name,
                  image: cat.image,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryProductsScreen(categoryName: cat.name),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

// Popular products section with horizontal scroll.
class PopularSection extends StatelessWidget {
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final popularProducts = provider.getProducts
            .take(5)
            .toList(); // Use first 5 as popular; customize as needed.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SubtitleWidget(label: 'Popular'),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularProducts.length,
                itemBuilder: (context, index) {
                  final product = popularProducts[index];
                  return PopularItemCard(product: product);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// Card for popular items in horizontal list.
class PopularItemCard extends StatelessWidget {
  final ProductModel product;
  const PopularItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                product.productImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.fastfood, size: 40),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
