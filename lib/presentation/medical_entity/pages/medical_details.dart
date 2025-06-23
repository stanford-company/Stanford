import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medapp/presentation/medical_entity/pages/medical_details_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart' show AppColors;
import '../../../data/medical_entity/model/medical_doctor.dart';
import '../../../data/medical_entity/model/medical_entity.dart';

class MedicalDetailsScreen extends StatelessWidget {
  final MedicalEntityModel? medicalEntity;
  final MedicalModel? medicalModel;

  const MedicalDetailsScreen({
    super.key,
    this.medicalEntity,
    this.medicalModel,
  });

  void _launchPhone() async {
    final Uri url = Uri.parse('tel:+962790000000');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Example for Amman

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MedicalDetailsImages(
              images:
                  medicalEntity?.images ?? [medicalModel?.imageUrl ?? ""] ?? [],
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Color(0xff80D5B5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.green,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'currently_available'.tr(),
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    medicalEntity?.name ?? medicalModel?.medicalName ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8),
                  if ((medicalEntity?.phone1 != null &&
                          medicalEntity!.phone1.isNotEmpty) ||
                      (medicalEntity?.phone2 != null &&
                          medicalEntity!.phone2.isNotEmpty))
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/svg/phone.svg",
                          width: 13.w,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          medicalEntity?.phone1 ?? medicalEntity?.phone2 ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.green,
                            decoration: TextDecoration.underline,
                            fontSize: 14.sp,
                            decorationColor: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 8),
                  Text(
                    'about_doctor'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    medicalEntity?.description ??
                        medicalModel?.description ??
                        "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'location'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),

                  SizedBox(height: 16),
                ],
              ),
            ),

            // Map
            Container(
              width: 360.w,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: AssetImage("assets/images/maps.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Book Now Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 360.w,
          height: 48.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF29A07B), Color(0xFF1B8064)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Color(0xFF156752), width: 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // outer shadow
                color: Color(0x80156752), // #15675280
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
              BoxShadow(
                // inner inset shadow
                color: Color(0x66FFFFFF), // #FFFFFF40
                offset: Offset(0, 2),
                blurRadius: 0,
                spreadRadius: 1,
                // requires flutter_inset_box_shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
            child: Center(
              child: Text(
                'book_now'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
