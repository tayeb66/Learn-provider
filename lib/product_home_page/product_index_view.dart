import 'package:flutter/material.dart';
import 'package:learn_provider/product_home_page/product_index_controller.dart';
import 'package:learn_provider/product_home_page/widgets/category_chips.dart';
import 'package:learn_provider/product_home_page/widgets/product_grid.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/home_page_image_slider.dart';

class ProductIndexView extends StatelessWidget {
  const ProductIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductHomePageController>(builder: (context, controller, child) {
      return Scaffold(
        body: Center(
          child: controller.isLoading
              ? SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Center(child: Icon(Icons.front_loader)),
            ),
          )
              : CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Good morning 👋',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      'Shop',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 18,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      if (controller.cartCount > 0)
                        Positioned(
                          top: -2,
                          right: 12,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE24B4A),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${controller.cartCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 12),
                          Icon(
                            Icons.search,
                            size: 16,
                            color: Color(0xFF999999),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Search products, brands...',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              if(controller.isLoading)...{
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: CircularProgressIndicator(),
                  ),
                ),
              }else if(controller.errorMessage != null)...{
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Color(0xFFE24B4A),
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          controller.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () =>
                              controller.fetchProducts(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              }else...{
                // ── Image Slider ────────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4),
                    child: HomeImageSlider(),
                  ),
                ),
                // ── Section label ───────────────────────────────────────
                const SliverToBoxAdapter(child: _SectionLabel(label: 'Categories')),

                // ── Category Chips ──────────────────────────────────────
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CategoryChips(),
                  ),
                ),

                // ── Section label ───────────────────────────────────────
                const SliverToBoxAdapter(
                  child: _SectionLabel(label: 'All Products'),
                ),

                // ── Product Grid ────────────────────────────────────────
                const ProductGrid(),
              }
            ],
          ),
        ),
        // ── Bottom Navigation ──────────────────────────────────────────
        bottomNavigationBar: const _BottomNav(),
      );
    },);
  }
}

// ─── Section Label ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF888888),
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ─── Bottom Navigation ──────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _NavItem(icon: Icons.home_outlined, label: 'Home', active: true),
              _NavItem(icon: Icons.search, label: 'Search'),
              _NavItem(icon: Icons.favorite_border, label: 'Wishlist'),
              _NavItem(icon: Icons.person_outline, label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF1A1A1A) : const Color(0xFFAAAAAA);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 22, color: color),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: active ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}


