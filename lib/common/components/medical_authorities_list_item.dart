import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/routes.dart';
import '../../data/medical_entity/model/medical_doctor.dart';
import '../../model/doctor.dart';

class MedicalAuthoritiesListItem extends StatelessWidget {
  final MedicalModel doctor;

  const MedicalAuthoritiesListItem({Key? key, required this.doctor})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(Routes.medicalDetails, arguments: doctor),
      child: Container(
        width: 144.w,
        height: 139.h,
        margin: EdgeInsets.symmetric(vertical: 2.h),
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(
            color: Color(0xffe3e3eb), // Border color
            width: 2.w, // Border width
          ),
          color: Color(0xfff3f3f6),
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xff43b18c),
                    width: 2.w, // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 35.w,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(doctor.imageUrl),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              doctor.medicalName,
              style: TextStyle(
                color: Color(0xff113f4e),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              doctor.categoryEn,
              style: TextStyle(
                color: Color(0xff6A717E),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
