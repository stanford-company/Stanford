import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/components/round_icon_button.dart';
import '../../../../core/utils/constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/appointments_history/model/appointments_history.dart';
import '../../appointments_history/bloc/appointments_cubit.dart';

class NextAppointmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsHistoryCubit, AppointmentsHistoryState>(
      builder: (context, state) {
        var cubit = context.read<AppointmentsHistoryCubit>();
        Appointment nextAppointment = cubit.getFirstUpcomingAppointments();

        if (state is AppointmentsHistoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AppointmentsHistoryLoaded) {
          if (state.appointments.isEmpty) {
            return Center(child: Text('no_appointments'.tr()));
          } else {
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
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary_color,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 10),

                      // Wrap this part with Expanded to push the button to the end
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              nextAppointment.medicalEntityNameAr,
                              style: TextStyle(
                                color: Color(0xff113f4e),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              nextAppointment.descriptionAr ?? "",
                              style: TextStyle(
                                color: Color(0xff686f7c),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                      cubit.getFirstUpcomingAppointmentsString(),
                      style: TextStyle(
                        color: Color(0xff113f4e),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: Color(0xffb2e8d1), // Background color
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Radius 16
                            border: Border.all(
                              color: Color(0xff80d5b5), // Border color
                              width: 2, // Border width
                            ),
                          ),
                          padding: const EdgeInsets.all(
                            6.0,
                          ), // Padding for compact spacing
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/svg/calendar.svg',
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                nextAppointment.appointmentDate,
                                style: TextStyle(
                                  color: Color(0xff113f4e),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: Color(0xffb2e8d1), // Background color
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ), // Radius 16
                            border: Border.all(
                              color: Color(0xff80d5b5), // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              6.0,
                            ), // Optional: Add padding for better text spacing
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/svg/watch.svg'),
                                SizedBox(width: 4.w),
                                Text(
                                  nextAppointment.appointmentTime,
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
        } else if (state is AppointmentsHistoryError) {
          return Center(child: Text('error_loading_appointments'.tr()));
        } else
          return SizedBox();
      },
    );
  }
}
