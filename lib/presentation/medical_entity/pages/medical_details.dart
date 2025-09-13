import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/components/basic_app_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/medical_entity/model/medical_doctor.dart';
import '../../../data/medical_entity/model/medical_entity.dart';
import 'appointment_screen.dart';
import 'medical_details_images.dart';

class MedicalDetailsScreen extends StatelessWidget {
  final MedicalEntityModel? medicalEntity;
  final MedicalModel? medicalModel;
  final bool isBooking;

  const MedicalDetailsScreen({
    super.key,
    this.medicalEntity,
    this.medicalModel,
    required this.isBooking,
  });

  void _launchPhone() async {
    final Uri url = Uri.parse('tel:+962790000000');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchMap(double latitude, double longitude) async {
    final String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
      await launchUrl(Uri.parse(googleMapUrl));
    } else {
      // Handle error if URL can't be launched
      print("Could not open the map.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double latitude = medicalEntity?.latitude ?? 0.0;
    final double longitude = medicalEntity?.longitude ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if ((medicalEntity?.images.isNotEmpty == true ||
                (medicalModel?.imageUrl?.isNotEmpty == true)))
              MedicalDetailsImages(
                images:
                    medicalEntity?.images ??
                    [medicalModel?.imageUrl ?? ""] ??
                    [],
              ),
            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    medicalEntity?.name ?? medicalModel?.medicalName ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Phone number
                  if ((medicalEntity?.phone1 != null &&
                          medicalEntity!.phone1!.isNotEmpty) ||
                      (medicalEntity?.phone2 != null &&
                          medicalEntity!.phone2!.isNotEmpty))
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
                  if (medicalEntity?.description != null &&
                          medicalEntity!.description!.isNotEmpty ||
                      medicalModel?.description != null &&
                          medicalModel!.description!.isNotEmpty) ...[
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
                  ],

                  SizedBox(height: 16),
                  // Location
                  Text(
                    'location'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    context.locale.languageCode == 'ar'
                        ? (medicalEntity?.addressAr ??
                              medicalModel?.addressAr ??
                              "")
                        : (medicalEntity?.address ??
                              medicalModel?.address ??
                              ""),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
            // Map with Google Pin
            InkWell(
              onTap: () {
                _launchMap(
                  latitude,
                  longitude,
                ); // Open the location in Google Maps
              },
              child: SizedBox(
                width: 450.w,
                height: 200.h,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        'assets/images/Untitled.png',
                        fit: BoxFit.cover,
                        width: 450.w,
                        height: 200.h,
                      ),
                    ),
                    Positioned(
                      left: 8.w,
                      child: Image.asset(
                        'assets/images/Google_Maps_Logo.svg.png',
                        width: 100.w,
                        height: 50.h,
                      ),
                    ),
                    Positioned(
                      top: 90.h,
                      left: 200.w,
                      child: Image.asset(
                        'assets/images/Google_Maps_pin.svg.png',
                        width: 40.w,
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Book Now Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isBooking == true
            ? BasicAppButton(
                text: "book_now",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(
                        medicalModel: medicalModel,
                        medicalEntity: medicalEntity,
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
      ),
    );
  }
}
