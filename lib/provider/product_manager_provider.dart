import 'package:flutter/material.dart';
import 'package:swigo_app/models/category_model.dart';
import 'package:swigo_app/models/product_model.dart';

// ProductProvider manages product and category data, notifying listeners on changes.
// Data is hardcoded for simplicity; in a real app, load from API or database.
class ProductProvider with ChangeNotifier {
  // Private list of products; exposed via getter for encapsulation.
  final List<ProductModel> _products = [
    // Phones (example data)
    ProductModel(
      productName: "Apple iPhone 14 Pro (128GB) - Black",
      description:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display...",
      price: 1399.99,
      category: "Phones",
      productImage: "https://i.ibb.co/BtMBSgK/1-iphone14-128gb-black.webp",
    ),
    ProductModel(
      productName: "Apple iPhone 16 Pro (128GB) - Black",
      description:
          "6.1-inch Super Retina XDR display with ProMotion and always-on displayrticles aren't about high-level app architecture, rather they're about solving specific design problems that improve your application's code base regardless of how you've architected your app. That said, the articles do assume the MVVM...",
      price: 1399.99,
      category: "Phones",
      productImage: "https://i.ibb.co/BtMBSgK/1-iphone14-128gb-black.webp",
    ),
    ProductModel(
      productName:
          "Samsung Galaxy S22 Ultra 5G - 256GB - Phantom Black (Unlocked)",
      description:
          "About this item 6.8 inch Dynamic AMOLED 2X display with a 3200 x 1440 resolution\n256GB internal storage, 12GB RAM\n108MP triple camera system with 100x Space Zoom and laser autofocus\n40MP front-facing camera with dual pixel",
      price: 1199.99,
      category: "Phones",
      productImage:
          "https://i.ibb.co/z5zMDCx/4-Samsung-Galaxy-S22-Ultra-5-G-256-GB-Phantom-Black-Unlocked.webp",
    ),
    // ... (rest of your products here; truncated for brevity)
    // Food Items
    ProductModel(
      productName: "Margherita Pizza",
      description:
          "Classic pizza with tomato sauce, mozzarella cheese, and fresh basil leaves",
      price: 2.99,
      category: "Pizza",
      productImage:
          "https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_1280.jpg",
    ),

    ProductModel(
      productName: "Gourmet, Pizza",
      description:
          "Classic pizza with tomato sauce, mozzarella cheese, and fresh basil leaves",
      price: 10.9,
      category: "Pizza",
      productImage:
          "https://cdn.pixabay.com/photo/2017/06/27/08/41/gourmet-2446699_1280.jpg",
    ),

    ProductModel(
      productName: "coke",
      description: "Classic coke and fresh basil leaves with zero suger",
      price: 16.99,
      category: "Drinks",
      productImage:
          "https://cdn.pixabay.com/photo/2019/04/04/11/42/soda-4102593_1280.jpg",
    ),
    ProductModel(
      productName: "Organic Strawberries",
      description:
          "Sweet, juicy organic strawberries picked at peak ripeness. Rich in antioxidants and vitamin C. Perfect for desserts, smoothies, or eating fresh.",
      price: 6.99,
      category: "Fruits",
      productImage:
          "https://cdn.pixabay.com/photo/2018/04/29/11/54/strawberries-3359755_1280.jpg",
    ),
    ProductModel(
      productName: "BBQ Bacon Burger",
      description:
          "Premium angus beef patty topped with smoked bacon, onion rings, cheddar cheese, and tangy BBQ sauce. Served with coleslaw and pickles.",
      price: 13.99,
      category: "Burgers",
      productImage:
          "https://cdn.pixabay.com/photo/2020/10/05/19/55/hamburger-5630646_1280.jpg",
    ),
    //Drinks
    ProductModel(
      productName: "Fresh Orange Juice",
      description:
          "Freshly squeezed orange juice with no added sugars or preservatives. Rich in vitamin C and naturally sweet. Served chilled.",
      price: 4.99,
      category: "Drinks",
      productImage:
          "https://cdn.pixabay.com/photo/2017/01/20/14/59/orange-1995044_1280.jpg",
    ),

    ProductModel(
      productName: "Lemonade",
      description: "Classic lemonade and fresh basil leaves with zero suger",
      price: 16.99,
      category: "Drinks",
      productImage:
          "https://cdn.pixabay.com/photo/2020/06/14/14/44/drink-5298126_1280.jpg",
    ),
    // ... (add all other products similarly)
  ];

  // Getter for products; returns a copy to prevent external mutations.
  List<ProductModel> get getProducts => List.unmodifiable(_products);

  // Predefined categories with asset images (assume assets/icons exist; update paths as needed).
  List<CategoryModel> get getCategories {
    return [
      CategoryModel(
        id: '1',
        name: 'Phones',
        image: 'assets/images/categories/smartphone.png',
      ),
      CategoryModel(
        id: '2',
        name: 'Pizza',
        image: 'assets/images/categories/pizza.png',
      ),
      CategoryModel(
        id: '3',
        name: 'Burgers',
        image: 'assets/images/categories/burger.png',
      ),
      CategoryModel(
        id: '4',
        name: 'Chicken',
        image: 'assets/images/categories/chicken.png',
      ),
      CategoryModel(
        id: '5',
        name: 'Fruits',
        image: 'assets/images/categories/fruit.png',
      ),
      CategoryModel(
        id: '6',
        name: 'Drinks',
        image: 'assets/images/categories/soft_drink.png',
      ),
    ];
  }

  // Cache for better performance
  final Map<String, ProductModel?> _productCache = {};
  final Map<String, List<ProductModel>> _categoryCache = {};
  final Map<String, List<ProductModel>> _searchCache = {};

  // Finds a product by ID with caching
  ProductModel? findProdId(String productId) {
    if (_productCache.containsKey(productId)) {
      return _productCache[productId];
    }
    
    try {
      final product = _products.firstWhere((element) => element.productid == productId);
      _productCache[productId] = product;
      return product;
    } catch (e) {
      _productCache[productId] = null;
      return null;
    }
  }

  // Filters products by category with caching
  List<ProductModel> findByCategory({required String categoryName}) {
    final key = categoryName.toLowerCase();
    if (_categoryCache.containsKey(key)) {
      return _categoryCache[key]!;
    }
    
    final result = _products
        .where((element) => element.category.toLowerCase() == key)
        .toList();
    _categoryCache[key] = result;
    return result;
  }

  // Searches products by name with caching
  List<ProductModel> searchQuery({required String searchText}) {
    final key = searchText.toLowerCase().trim();
    if (key.isEmpty) return _products;
    
    if (_searchCache.containsKey(key)) {
      return _searchCache[key]!;
    }
    
    final result = _products
        .where((element) => 
            element.productName.toLowerCase().contains(key) ||
            element.description.toLowerCase().contains(key))
        .toList();
    
    // Limit cache size to prevent memory issues
    if (_searchCache.length > 50) {
      _searchCache.clear();
    }
    _searchCache[key] = result;
    return result;
  }

  // Clear caches when data changes
  void clearCaches() {
    _productCache.clear();
    _categoryCache.clear();
    _searchCache.clear();
  }
}
