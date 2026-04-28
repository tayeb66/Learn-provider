import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key, required this.onAddToCart, required this.onAddToWishlist});

  final void Function() onAddToCart;
  final void Function() onAddToWishlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width:  double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onAddToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Add to Cart',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width:  double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: onAddToWishlist,
            style: OutlinedButton.styleFrom(
              side:  BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Add to Wishlist',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }
}