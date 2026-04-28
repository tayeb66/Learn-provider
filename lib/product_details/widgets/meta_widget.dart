import 'package:flutter/material.dart';
import 'package:learn_provider/product_details/product_details.dart';

class MetaWidget extends StatelessWidget {
  final Meta? meta;

  const MetaWidget({super.key, this.meta});

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
            'Meta',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey, letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),
          _MetaRow(label: 'Barcode', value: meta?.barcode ?? '-'),
          _MetaRow(label: 'QR Code', value: meta?.qrCode ?? '-'),
          _MetaRow(label: 'Created at', value: meta?.createdAt ?? '-'),
          _MetaRow(label: 'Updated at', value: meta?.updatedAt ?? '-', isLast: true),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _MetaRow({required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
      ],
    );
  }
}
