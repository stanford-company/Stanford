import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/category/model/category.dart';  // Import CategoryModel

class HealthConcernItem extends StatelessWidget {
  final CategoryModel healthCategory;
  final VoidCallback onTap;

  const HealthConcernItem({
    Key? key,
    required this.healthCategory,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Use static SVG icon
          SvgPicture.asset(
            'assets/images/svg/major_icon.svg',  // Static SVG file
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10),
          // Display name based on language
          Text(
            // context.locale.languageCode == 'ar'
            //     ? healthCategory.nameAr
                healthCategory.nameEn,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,  // Or bodyLarge
          ),
        ],
      ),
    );
  }
}
