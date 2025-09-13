import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/core/constants/app_colors.dart';
import 'package:medapp/domain/appointments_history/usecase/appointments_usecase.dart';

import '../bloc/appointments_cubit.dart';

class BookedPage extends StatelessWidget {
  const BookedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filterKeys = [
      'filter_all',
      'filter_upcoming',
      'filter_accepted',
      'filter_previous',
    ];

    final lang = Localizations.localeOf(context).languageCode;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // Filter chips
          BlocBuilder<AppointmentsHistoryCubit, AppointmentsHistoryState>(
            builder: (context, state) {
              if (state is AppointmentsHistoryLoaded)
                return SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterKeys.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final label = filterKeys[index].tr(); // ✅ الترجمة هنا

                      return GestureDetector(
                        onTap: () {
                          print('Filter tapped: $label');
                          switch (index) {
                            case 0:
                              context
                                  .read<AppointmentsHistoryCubit>()
                                  .getAllAppointments();
                              break;
                            case 1:
                              context
                                  .read<AppointmentsHistoryCubit>()
                                  .getUpcomingAppointments();
                              break;
                            case 2:
                              context
                                  .read<AppointmentsHistoryCubit>()
                                  .getAcceptedAppointments();
                              break;
                            case 3:
                              context
                                  .read<AppointmentsHistoryCubit>()
                                  .getPreviousAppointments();
                              break;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: label == state.filter
                                ? AppColors.green
                                : AppColors.light_grey_color,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Center(
                            child: Text(
                              label,
                              style: TextStyle(
                                color: index == 0
                                    ? AppColors.primary_color
                                    : const Color(0xff6A717E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              return const SizedBox(); // Return empty if not loaded
            },
          ),
          const SizedBox(height: 16),
          // Appointments list
          Expanded(
            child:
                BlocBuilder<AppointmentsHistoryCubit, AppointmentsHistoryState>(
                  builder: (context, state) {
                    if (state is AppointmentsHistoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AppointmentsHistoryError) {
                      return Center(child: Text(state.message));
                    } else if (state is AppointmentsHistoryLoaded) {
                      final appointments = state.appointments;
                      return ListView.builder(
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          final item = appointments[index];
                          final name = lang == 'ar'
                              ? item.medicalEntityNameAr
                              : item.medicalEntityName;
                          final desc = lang == 'ar'
                              ? item.descriptionAr
                              : item.description;

                          Color statusColor;
                          switch (item.status) {
                            case 'confirmed':
                            case 'تم التأكيد':
                              statusColor = AppColors.secondary_color;
                              break;
                            case 'pending':
                            case 'جاري التأكيد':
                              statusColor = const Color(0x33FF9500);
                              break;
                            case 'rejected':
                            case 'مرفوض':
                              statusColor = Colors.red.shade200;
                              break;
                            default:
                              statusColor = AppColors.secondary_color;
                          }

                          return Card(
                            color: AppColors.light_grey_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Status badge
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item.status,
                                      style: TextStyle(
                                        color: AppColors.primary_color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Doctor info
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor:
                                            AppColors.primary_color,
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          Text(desc ?? ''),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  // Time & date
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary_color,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 18,
                                              color: AppColors.primary_color,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              item.appointmentTime,
                                              style: TextStyle(
                                                color: AppColors.primary_color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary_color,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 18,
                                              color: AppColors.primary_color,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              item.appointmentDate,
                                              style: TextStyle(
                                                color: AppColors.primary_color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox(); // Initial or unknown state
                  },
                ),
          ),
        ],
      ),
    );
  }
}
