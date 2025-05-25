import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/doctor.dart';

class MedicalAuthoritiesListItem extends StatelessWidget {
  final Doctor doctor;

  const MedicalAuthoritiesListItem({
    Key? key,
    required this.doctor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 144.w,
      height: 139.h,
      margin: EdgeInsets.symmetric(vertical: 4.h),
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
          Container(
            width: 50.w, // radius * 2
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xff43b18c), // Border color
                width: 2.w, // Border width
              ),
            ),
            child: CircleAvatar(
              radius: 30.w,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(doctor.avatar!),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            doctor.name!,
            style: TextStyle(
              color: Color(0xff113f4e),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            doctor.speciality!,
            style: TextStyle(
              color: Color(0xff6A717E),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
