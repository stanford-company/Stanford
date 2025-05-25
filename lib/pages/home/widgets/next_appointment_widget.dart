import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/round_icon_button.dart';
import '../../../utils/constants.dart';

class NextAppointmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        color: Color(0xfff3f3f6),
        border: Border.all(
          width: 2,
          color: Color(0xffe3e3eb), // light gray border
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/images/icon_doctor_1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 10),

              // Wrap this part with Expanded to push the button to the end
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   <Widget>[
                    Text(
                      'Tawfiq Bahri',
                      style: TextStyle(
                        color: Color(0xff113f4e),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Family Doctor, Cardiologist',
                      style: TextStyle(
                        color: Color(0xff686f7c),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SvgPicture.asset(
                'assets/images/svg/edit-svg.svg',
                width: 40.w,
                height: 40.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
          Divider(
            color: Color(0xffe3e3eb),
            height: 30,
            thickness: 3.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Text(
              'Tomorrow',
              style: TextStyle(
                color: Color(0xff113f4e),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0.w),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: Color(0xffb2e8d1), // Background color
                    borderRadius: BorderRadius.circular(12), // Radius 16
                    border: Border.all(
                      color: Color(0xff80d5b5), // Border color
                      width: 2, // Border width
                    ),
                  ),
                  padding: const EdgeInsets.all(6.0), // Padding for compact spacing
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/svg/calendar.svg'),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '6-05-2025',
                        style: TextStyle(
                          color: Color(0xff113f4e),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: Color(0xffb2e8d1), // Background color
                    borderRadius: BorderRadius.all(Radius.circular(12)), // Radius 16
                    border: Border.all(
                      color: Color(0xff80d5b5), // Border color
                      width: 2, // Border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0), // Optional: Add padding for better text spacing
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/svg/watch.svg'),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          '05:00 PM - 05:30 PM',
                          style: TextStyle(
                            color: Color(0xff113f4e),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
