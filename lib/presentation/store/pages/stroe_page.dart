import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/common/components/search_widget.dart';

import '../../../common/bloc/bottom_bar_cubit.dart';
import '../../../core/routes/routes.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'الكل',
      'مستلزمات طبية',
      'أجهزة طبية',
      'أدوية',
      'أخرى',
    ];
    final List<Map<String, String>> items = List.generate(9, (index) {
      return {
        'title': 'كرسي متحرك',
        'price': '100 دينار',
        'image': 'assets/images/Rectangle 4.png', // Replace with actual images
      };
    });
    return Column(
      children: [
        SearchWidget(),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            itemCount: categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = index == 0;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: isSelected ? Color(0xff43B18C) : Color(0xfff3f3f6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected ? Color(0xff113F4E) : Color(0xff585678),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () async {
                    context.read<BottomBarCubit>().hide();

                    await Navigator.pushNamed(context, Routes.productDetails);
                    context.read<BottomBarCubit>().show();
                  },
                  child: Container(
                    color: Color(0xfff3f3f6),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          item['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff113F4E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 2),
                        Text(
                          item['price']!,
                          style: TextStyle(
                            color: Color(0xff1B8064),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
