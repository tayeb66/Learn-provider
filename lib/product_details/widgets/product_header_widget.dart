import 'package:flutter/material.dart';

class ProductHeaderWidget extends StatelessWidget {
  final String? title;
  final String? brand;
  final String? sku;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final List<String>? tags;
  final String? availabilityStatus;

  const ProductHeaderWidget({
    super.key,
    this.title,
    this.brand,
    this.sku,
    this.price,
    this.discountPercentage,
    this.rating,
    this.tags,
    this.availabilityStatus,
  });

  @override
  Widget build(BuildContext context) {
    final originalPrice = price != null && discountPercentage != null ? price! / (1 - discountPercentage! / 100) : null;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(title ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              if (availabilityStatus != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                  child: Text(availabilityStatus!, style: TextStyle(fontSize: 11, color: Colors.green.shade700)),
                ),
            ],
          ),
          const SizedBox(height: 4),

          // Brand & SKU
          Text(
            'Brand: ${brand ?? '-'}  |  SKU: ${sku ?? '-'}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 10),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$${price?.toStringAsFixed(2) ?? '-'}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8),
              if (originalPrice != null)
                Text(
                  '\$${originalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade400, decoration: TextDecoration.lineThrough),
                ),
              const SizedBox(width: 8),
              if (discountPercentage != null)
                Text(
                  '${discountPercentage!.toStringAsFixed(0)}% off',
                  style: TextStyle(fontSize: 13, color: Colors.green.shade600),
                ),
            ],
          ),
          const SizedBox(height: 8),

          // Rating row
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < (rating ?? 0).floor() ? Icons.star : Icons.star_border,
                  size: 16,
                  color: Colors.amber,
                );
              }),
              const SizedBox(width: 6),
              Text(rating?.toStringAsFixed(1) ?? '-', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ],
          ),
          const SizedBox(height: 10),

          // Tags
          if (tags != null && tags!.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags!
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 12)),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
