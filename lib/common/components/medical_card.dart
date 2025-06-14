import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medapp/data/medical_entity/model/medical_entity.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/routes.dart';

class MedicalCard extends StatelessWidget {
  final MedicalEntityModel medicalEntity;
  const MedicalCard({super.key, required this.medicalEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xfff3f3f6),
        border: Border.all(color: Color(0xffe3e3eb), width: 2),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        leading: CircleAvatar(
          radius: 26.r,
          backgroundImage: medicalEntity.images.isNotEmpty
              ? NetworkImage(medicalEntity.images[0])
              : null,
        ),
        title: Text(
          medicalEntity.name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                medicalEntity.description,
                style: TextStyle(fontSize: 13.sp, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                '•',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ),
            Text(medicalEntity.city.nameAr, style: TextStyle(fontSize: 13.sp)),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.primary_button_color,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.bookingStep3);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary_button_color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                elevation: 4, // default elevation
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "book_now".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.w, left: 8.w),
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(
                              0.17,
                            ), // white glow for the arrow circle
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Transform.rotate(
                          angle: pi,
                          child: SvgPicture.asset(
                            'assets/images/svg/single_arrow.svg',
                            width: 10.w,
                            height: 10.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
