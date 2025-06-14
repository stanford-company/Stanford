
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';
import 'package:medapp/model/medical_centers.dart';

class MedicalCentersListItem extends StatelessWidget {
  final MedicalModel medicalCenter;

  const MedicalCentersListItem({Key? key, required this.medicalCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.w,
      height: 170.h,
      margin: EdgeInsets.symmetric(vertical: 0.h),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(color: const Color(0xffe3e3eb), width: 0.5.w),
        color: const Color(0xfff3f3f6),
      ),
      child: Column(
        children: <Widget>[
          // Top: Hospital Image with more height
          SizedBox(
            height: 80.h,
            width: double.infinity,
            child: medicalCenter.imageUrl.isNotEmpty
                ? Image.network(medicalCenter.imageUrl, fit: BoxFit.cover)
                : Container(
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 40.sp, color: Colors.grey),
            ),
          ),
          // Bottom: Hospital name and specialty
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  medicalCenter.medicalName ?? '',
                  style: TextStyle(
                    color: const Color(0xff113f4e),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  medicalCenter.categoryEn ?? '',
                  style: TextStyle(
                    color: const Color(0xff6A717E),
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
        ],
      ),
    );
  }
}

class MedicalCentersGrid extends StatelessWidget {
  final List<MedicalModel> medicalCenters;

  const MedicalCentersGrid({super.key, required this.medicalCenters});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 190 / 190,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      children: medicalCenters
          .map((center) => MedicalCentersListItem(medicalCenter: center))
          .toList(),
    );
  }
}
