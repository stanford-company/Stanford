import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medapp/presentation/category/bloc/category_cubit.dart';
import '../../../../common/components/health_concern_item.dart';
import '../../../../core/routes/routes.dart';
import '../../../../data/category/model/category.dart';

class HealthConcernPage extends StatefulWidget {
  @override
  _HealthConcernPageState createState() => _HealthConcernPageState();
}

class _HealthConcernPageState extends State<HealthConcernPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getCategories(),
      child: Scaffold(
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            var cubit = context.read<CategoryCubit>();
            if (state is CategoryLoaded) {
              // Store all categories initially
              // If no filtering, show all

              return Column(
                children: [
                  SizedBox(height: 12.h),
                  Divider(
                    thickness: 1.2.h,
                    color: Color(0xffEAECF0),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/svg/Search Icon.svg',
                                  width: 24.w,
                                  height: 24.h,
                                  color: Colors.green.shade700,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'search_for_clinics_doctors_hospitals'.tr(),
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    onChanged: cubit.onSearchChanged,  // Call _onSearchChanged when text changes
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select medical condition'.tr(),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        itemCount: state.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.8,
                        ),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return HealthConcernItem(
                            healthCategory: category,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.bookingStepCity,
                                arguments: category.id,
                              );
                              context.read<CategoryCubit>().toggleCategorySelection(
                                category.id.toString(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}
