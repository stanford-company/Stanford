import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/core/constants/app_colors.dart';

class BookedPage extends StatelessWidget {
  const BookedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      'الكل',
      'المواعيد القادمة',
      'المواعيد المقبولة',
      'المواعيد السابقة',
    ];
    final appointments = [
      {
        'status': 'تم التأكيد',
        'statusColor': AppColors.secondary_color,
        'name': 'جود العساف',
        'specialty': 'طبيب قلب',
        'location': 'عمان',
        'time': '05:00 PM - 05:30 PM',
        'date': '6-05-2025',
      },
      {
        'status': 'جاري التأكيد',
        'statusColor': Color(0x33FF9500),
        'name': 'فداء النابلسي',
        'specialty': 'طبيب قلب',
        'location': 'عمان',
        'time': '05:00 PM - 05:30 PM',
        'date': '6-05-2025',
      },
      {
        'status': 'مرفوض',
        'statusColor': Colors.red.shade200,
        'name': 'ريهام المجالي',
        'specialty': 'طبيب قلب',
        'location': 'عمان',
        'time': '05:00 PM - 05:30 PM',
        'date': '6-05-2025',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: index == 0
                        ? AppColors.green
                        : AppColors.light_grey_color,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Center(
                    child: Text(
                      filters[index],
                      style: TextStyle(
                        color: index == 0
                            ? AppColors.primary_color
                            : Color(0xff6A717E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Appointment cards
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final item = appointments[index];
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
                            color: item['statusColor'] as Color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['status'] as String,
                            style: TextStyle(color: AppColors.primary_color),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Doctor info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: AppColors.primary_color,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Text(
                                  '${item['specialty']} · ${item['location']}',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
                                borderRadius: BorderRadius.circular(12),
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
                                    item['time'] as String,
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
                                borderRadius: BorderRadius.circular(12),
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
                                    item['date'] as String,
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
            ),
          ),
        ],
      ),
    );
  }
}
