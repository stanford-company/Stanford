// lib/presentation/category_network/widget/category_network_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding:   EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE4E4E4)),
          borderRadius: BorderRadius.circular(6.w),
          color: Color(0xfff3f3f6),
        ),
        child: Center(
          child: Text(
            healthCategory.nameAr ?? "No name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
