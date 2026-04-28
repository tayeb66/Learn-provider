import 'package:flutter/material.dart';
import 'package:learn_provider/product_details/product_details.dart';

class ReviewsWidget extends StatelessWidget {
  final List<Reviews>? reviews;

  const ReviewsWidget({super.key, this.reviews});

  @override
  Widget build(BuildContext context) {
    final list = reviews ?? [];

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
            'Customer Reviews',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey, letterSpacing: 0.8),
          ),
          const SizedBox(height: 12),
          if (list.isEmpty)
            const Text('No reviews yet.', style: TextStyle(fontSize: 13, color: Colors.grey))
          else
            ...list.map((review) => _ReviewCard(review: review)),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Reviews review;

  const _ReviewCard({required this.review});

  String _initials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    return parts.length >= 2 ? '${parts[0][0]}${parts[1][0]}'.toUpperCase() : parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue.shade50,
                child: Text(
                  _initials(review.reviewerName),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blue.shade700),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.reviewerName ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    Text(review.date ?? '', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < (review.rating ?? 0).floor() ? Icons.star : Icons.star_border,
                    size: 14,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(review.comment ?? '', style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.5)),
        ],
      ),
    );
  }
}
