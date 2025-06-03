import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../data/category/model/category.dart';

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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        height: 50.h,
        decoration: BoxDecoration(
          color: Color(0xfff3f3f6),
          border: Border.all(color: Color(0xffE4E4E4)),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/svg/major_icon.svg',
              width: 30.w,
              height: 30.h,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                healthCategory.nameEn,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff113f4e),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
