import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/routes/routes.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => print("Filter button clicked"),
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xff13434A),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/svg/IC_Filter.svg',
                  width: 24.w,
                  height: 24.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade400),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/Search Icon.svg',
                    width: 24.w,
                    height: 24.h,
                    color: Colors.green.shade700,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      onTap: () => Navigator.pushNamed(context, Routes.search),
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for clinics, doctors, hospitals',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
