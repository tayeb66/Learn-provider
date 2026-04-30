import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learn_provider/product_home_page/product_index_controller.dart';
import 'package:learn_provider/product_home_page/product_index_model.dart';
import 'package:provider/provider.dart';

class HomeImageSlider extends StatelessWidget {
  const HomeImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductHomePageController>();
    final slides = provider.sliderProducts;
    final currentIndex = provider.sliderIndex;

    if (slides.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            itemCount: slides.length,
            onPageChanged: (i) => provider.setSliderIndex(i),
            itemBuilder: (context, index) {
              return _SliderCard(product: slides[index]);
            },
          ),
        ),
        const SizedBox(height: 10),
        _SliderDots(total: slides.length, current: currentIndex),
      ],
    );
  }
}

// ─── Individual Slide Card ─────────────────────────────────────────────────

class _SliderCard extends StatelessWidget {
  final Products product;

  const _SliderCard({required this.product});

  // Map category → gradient colors
  List<Color> _gradientColors(String? category) {
    switch (category?.toLowerCase()) {
      case 'smartphones':
        return [const Color(0xFF185FA5), const Color(0xFF378ADD)];
      case 'laptops':
        return [const Color(0xFF533AB7), const Color(0xFF7F77DD)];
      case 'fragrances':
        return [const Color(0xFF993556), const Color(0xFFD4537E)];
      case 'skincare':
        return [const Color(0xFF3B6D11), const Color(0xFF639922)];
      default:
        return [const Color(0xFF444441), const Color(0xFF888780)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _gradientColors(product.category);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            CachedNetworkImage(
              imageUrl: product.thumbnail ?? '',
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

            // Gradient overlay for text legibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.black.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),

            // Slide content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Discount / eyebrow
                  if ((product.discountPercentage ?? 0) > 0)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE24B4A),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Up to ${product.discountPercentage?.toStringAsFixed(0)}% off',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  // Title
                  Text(
                    product.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Shop Now button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    child: const Text(
                      'Shop Now →',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Slide counter badge
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  product.brand ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Dot Indicators ────────────────────────────────────────────────────────

class _SliderDots extends StatelessWidget {
  final int total;
  final int current;

  const _SliderDots({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: isActive
                ? const Color(0xFF1A1A1A)
                : const Color(0xFFCCCCCC),
          ),
        );
      }),
    );
  }
}
