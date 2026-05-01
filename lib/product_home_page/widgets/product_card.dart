import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_provider/Routes/app_routes.dart';
import 'package:learn_provider/product_home_page/product_index_controller.dart';
import 'package:provider/provider.dart';

import '../product_index_model.dart';

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductHomePageController>();
    final isWishlisted = provider.isWishlisted(product.id ?? 0);

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Routes.productDetails,arguments: <String,dynamic>{"id" : product.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image area ───────────────────────────────────────────────
            Expanded(
              child: Stack(
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: product.thumbnail ?? '',
                        fit: BoxFit.cover,
                        placeholder: (_, _) => Container(
                          color: const Color(0xFFF5F5F5),
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 1.5),
                          ),
                        ),
                        errorWidget: (_, _, _) => Container(
                          color: const Color(0xFFF0F0F0),
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: Color(0xFFCCCCCC),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Discount badge
                  if ((product.discountPercentage ?? 0) > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE24B4A),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '-${product.discountPercentage?.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                  // Wishlist button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => context
                          .read<ProductHomePageController>()
                          .toggleWishlist(product.id ?? 0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 16,
                          color: isWishlisted
                              ? const Color(0xFFE24B4A)
                              : const Color(0xFF888888),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Product info ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand
                  if (product.brand != null)
                    Text(
                      product.brand!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                      ),
                    ),
                  const SizedBox(height: 2),

                  // Title
                  Text(
                    product.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Rating stars
                  _RatingRow(rating: product.rating ?? 0),
                  const SizedBox(height: 4),

                  // Stock status
                  _StockStatus(product: product),
                  const SizedBox(height: 6),

                  // Price + Add to cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${product.discountedPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          if ((product.discountPercentage ?? 0) > 0)
                            Text(
                              '\$${product.price?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFFAAAAAA),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                      // Add to cart button
                      GestureDetector(
                        onTap: () =>
                            context.read<ProductHomePageController>().addToCart(product),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A1A1A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Rating Row ────────────────────────────────────────────────────────────

class _RatingRow extends StatelessWidget {
  final double rating;
  const _RatingRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < rating.floor()) {
            return const Icon(Icons.star, size: 11, color: Color(0xFFF0A500));
          } else if (i < rating) {
            return const Icon(
              Icons.star_half,
              size: 11,
              color: Color(0xFFF0A500),
            );
          }
          return const Icon(
            Icons.star_border,
            size: 11,
            color: Color(0xFFCCCCCC),
          );
        }),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF999999),
          ),
        ),
      ],
    );
  }
}

// ─── Stock Status ──────────────────────────────────────────────────────────

class _StockStatus extends StatelessWidget {
  final Products product;
  const _StockStatus({required this.product});

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    Color textColor;
    String label;

    if (!product.isInStock) {
      dotColor = const Color(0xFFE24B4A);
      textColor = const Color(0xFFA32D2D);
      label = 'Out of stock';
    } else if (product.isLowStock) {
      dotColor = const Color(0xFFEF9F27);
      textColor = const Color(0xFF854F0B);
      label = 'Low stock · ${product.stock} left';
    } else {
      dotColor = const Color(0xFF4CAF50);
      textColor = const Color(0xFF3B6D11);
      label = 'In stock';
    }

    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 9, color: textColor),
        ),
      ],
    );
  }
}
