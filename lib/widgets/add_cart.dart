import 'package:flutter/material.dart';

class AddToCartWidget extends StatefulWidget {
  final String productName;
  final VoidCallback? onAddToCart;

  const AddToCartWidget({
    super.key,
    required this.productName,
    this.onAddToCart,
  });

  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Compact quantity selector
        Container(
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: quantity > 1 ? () => setState(() => quantity--) : null,
                child: Container(
                  width: 20,
                  height: 24,
                  decoration: BoxDecoration(
                    color: quantity > 1
                        ? Colors.grey.shade100
                        : Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 12,
                    color: quantity > 1
                        ? Colors.black54
                        : Colors.grey.shade400,
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 24,
                color: Colors.white,
                child: Center(
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => quantity++),
                child: Container(
                  width: 20,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        // Compact Add to Cart button
        Expanded(
          child: GestureDetector(
            onTap: () => _addToCart(),
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added ${widget.productName} (x$quantity) to cart!',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    setState(() => quantity = 1);
    widget.onAddToCart?.call();
  }
}