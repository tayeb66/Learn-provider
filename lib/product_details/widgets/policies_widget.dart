import 'package:flutter/material.dart';

class PoliciesWidget extends StatelessWidget {
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? returnPolicy;

  const PoliciesWidget({super.key, this.warrantyInformation, this.shippingInformation, this.returnPolicy});

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
            'Policies',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey, letterSpacing: 0.8),
          ),
          const SizedBox(height: 8),
          _PolicyRow(icon: Icons.shield_outlined, label: 'Warranty', value: warrantyInformation),
          _PolicyRow(icon: Icons.local_shipping_outlined, label: 'Shipping', value: shippingInformation),
          _PolicyRow(icon: Icons.assignment_return_outlined, label: 'Returns', value: returnPolicy, isLast: true),
        ],
      ),
    );
  }
}

class _PolicyRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool isLast;

  const _PolicyRow({required this.icon, required this.label, this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade500),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                    Text(value ?? '-', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
      ],
    );
  }
}
