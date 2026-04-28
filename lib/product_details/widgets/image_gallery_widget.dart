import 'package:flutter/material.dart';

class ImageGalleryWidget extends StatefulWidget {
  final List<String>? images;
  final String? thumbnail;

  const ImageGalleryWidget({super.key, this.images, this.thumbnail});

  @override
  State<ImageGalleryWidget> createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images ?? [];

    return Column(
      children: [
        // Main image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            images.isNotEmpty ? images[_selectedIndex] : widget.thumbnail ?? '',
            height: 400,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => Container(height: 260, color: Colors.grey[200]),
          ),
        ),
        const SizedBox(height: 10),

        // Thumbnail strip
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: isSelected ? Colors.blue : Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(color: Colors.grey[200]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
