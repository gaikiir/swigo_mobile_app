// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:swigo_app/provider/product_manager_provider.dart';
// import 'package:swigo_app/widgets/product_widget.dart';

// class SearchWidget extends StatefulWidget {
//   final Function(String)? onChanged;
//   final VoidCallback? onFilterTap;

//   const SearchWidget({super.key, this.onChanged, this.onFilterTap});

//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }

// class _SearchWidgetState extends State<SearchWidget> {
//   final TextEditingController _controller = TextEditingController();
//   String _searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _controller,
//           decoration: InputDecoration(
//             prefixIcon: const Icon(Icons.search),
//             suffixIcon: GestureDetector(
//               onTap: () {
//                 _controller.clear();
//                 setState(() {
//                   _searchQuery = '';
//                 });
//                 if (widget.onChanged != null) {
//                   widget.onChanged!('');
//                 }
//               },
//               child: const Icon(Icons.clear, color: Colors.redAccent),
//             ),
//             hintText: 'Search for drinks, food here...',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//           ),
//           onChanged: (value) {
//             setState(() {
//               _searchQuery = value;
//             });
//             if (widget.onChanged != null) {
//               widget.onChanged!(value);
//             }
//           },
//         ),
//         if (_searchQuery.isNotEmpty) ...[
//           const SizedBox(height: 16),
//           Expanded(
//             child: Consumer<ProductProvider>(
//               builder: (context, provider, child) {
//                 final products = provider.getProducts.where((p) {
//                   final q = _searchQuery.toLowerCase();
//                   return p.productName.toLowerCase().contains(q) ||
//                       p.description.toLowerCase().contains(q);
//                 }).toList();

//                 if (products.isEmpty) {
//                   return _buildEmptyState();
//                 }

//                 return GridView.builder(
//                   padding: const EdgeInsets.all(12),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.7,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                   ),
//                   itemCount: products.length,
//                   itemBuilder: (context, index) =>
//                       ProductWidget(product: products[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             'No products found',
//             style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try searching for something else',
//             style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
