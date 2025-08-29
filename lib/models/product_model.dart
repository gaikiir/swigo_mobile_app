class ProductModel {
  String? productid; // Optional ID, can be set later (e.g., from database).
  String productName;
  String description;
  double price;
  String category;
  String productImage;

  ProductModel({
    this.productid,
    required this.productName,
    required this.description,
    required this.category,
    required this.price,
    required this.productImage,
  });

  // Factory constructor to create from a map (e.g., from Firestore or JSON).
  // Uses null coalescing for robustness against missing data.
  factory ProductModel.fromMap(String productid, Map<String, dynamic> map) {
    return ProductModel(
      productid: productid,
      productName: map['productName'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'Uncategorized',
      price: (map['price'] ?? 0).toDouble(),
      productImage: map['productImage'] ?? '',
    );
  }

  // Converts the model to a map for storage or serialization.
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'category': category,
      'price': price,
      'productImage': productImage,
    };
  }
}
