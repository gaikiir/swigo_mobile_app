import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swigo_app/provider/product_manager_provider.dart';
import 'package:swigo_app/screens/list_category.dart';
import 'package:swigo_app/widgets/category_widget.dart';
import 'package:swigo_app/widgets/title_widget.dart';

// CategoryScreen displays all categories in a responsive grid.
class CategoryScreen extends StatefulWidget {
  static const routeName = '/CategoryScreen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const TitleWidget(lable: 'Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            int crossAxisCount = (width / 120).floor().clamp(
              3,
              6,
            ); // Responsive columns.
            return Consumer<ProductProvider>(
              builder: (context, provider, child) {
                final categories = provider.getCategories;
                return GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
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
        ),
      ),
    );
  }
}
