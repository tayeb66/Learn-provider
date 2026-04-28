import 'package:flutter/material.dart';

class ProductDescriptionWidget extends StatelessWidget {
  final String? description;

  const ProductDescriptionWidget({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey, letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),
          Text(description ?? '-', style: const TextStyle(fontSize: 14, height: 1.7, color: Colors.black87)),
        ],
      ),
    );
  }
}
