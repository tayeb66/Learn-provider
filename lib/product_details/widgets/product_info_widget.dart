import 'package:flutter/material.dart';
import 'package:learn_provider/product_details/product_details_model.dart';

class ProductInfoWidget extends StatelessWidget {
  final String? category;
  final int? weight;
  final int? stock;
  final int? minimumOrderQuantity;
  final Dimensions? dimensions;

  const ProductInfoWidget({
    super.key,
    this.category,
    this.weight,
    this.stock,
    this.minimumOrderQuantity,
    this.dimensions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Product Details',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey, letterSpacing: 0.8),
          ),
          const SizedBox(height: 12),

          // Info grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.8,
            children: [
              _InfoTile(label: 'Category', value: category ?? '-'),
              _InfoTile(label: 'Weight', value: weight != null ? '$weight g' : '-'),
              _InfoTile(label: 'Stock', value: stock != null ? '$stock units' : '-'),
              _InfoTile(label: 'Min. Order', value: minimumOrderQuantity != null ? '$minimumOrderQuantity unit' : '-'),
            ],
          ),

          if (dimensions != null) ...[
            const Divider(height: 24),
            const Text(
              'Dimensions',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey, letterSpacing: 0.8),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _InfoTile(label: 'Width', value: '${dimensions!.width} cm'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoTile(label: 'Height', value: '${dimensions!.height} cm'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoTile(label: 'Depth', value: '${dimensions!.depth} cm'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
