import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/pref_manager.dart';
import '../../../../core/utils/constants.dart';

class NavBarItemWidget extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String label;
  final bool isSelected;

  const NavBarItemWidget({
    Key? key,
    required this.onTap,
    required this.image,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  Color get _color => isSelected
      ? Colors.white
      : Prefs.isDark()
      ? Colors.grey[800]!
      : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 60.h,
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image.isNotEmpty)
              SvgPicture.asset(
                image,
                height: 24.h,
                color: _color,
              ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: _color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

