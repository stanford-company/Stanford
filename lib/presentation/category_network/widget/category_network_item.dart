// lib/presentation/category_network/widget/category_network_item.dart

import 'package:flutter/material.dart';
import 'package:medapp/data/category_network/model/category.dart';

class HealthConcernNetworkItem extends StatelessWidget {
  final CategoryNetworkModel healthCategory;
  final VoidCallback? onTap;

  const HealthConcernNetworkItem({
    Key? key,
    required this.healthCategory,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            healthCategory.nameAr ?? "No name", // غيّر إذا عندك لغة ثانية
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
