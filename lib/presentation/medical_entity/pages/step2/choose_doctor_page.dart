import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medapp/common/components/medical_card.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../common/components/custom_navigation_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../data/medical_entity/model/medical_entity.dart';
import '../../../main_home/widgets/nav_bar_item_widget.dart';
import '../../bloc/entity_cubit.dart';

class ChooseDoctorPage extends StatefulWidget {
  final String cityId;
  final int categoryId;
  final bool isBooking;

  const ChooseDoctorPage({
    super.key,
    required this.cityId,
    required this.isBooking,
    required this.categoryId,
  });

  @override
  State<ChooseDoctorPage> createState() => _ChooseDoctorPageState();
}

class _ChooseDoctorPageState extends State<ChooseDoctorPage> {
  int _selectedIndex = 2;
  late PageController _pageController;
  int? cityId;
  bool _didFetch = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EntityCubit()
        ..getEntities(
          cityId: int.parse(widget.cityId),
          categoryId: widget.categoryId,
        ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(92.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 60.h,
                  leading: IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/images/svg/arrow_back.svg',
                      width: 45.w,
                      height: 45.h,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    "book_an_appointment".tr(),
                    style: TextStyle(color: Color(0xff113f4e), fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          ),
        ),

        body: BlocBuilder<EntityCubit, EntityState>(
          builder: (context, state) {
            return Column(
              children: [
                // Search bar implementation
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
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
                            onChanged: context
                                .read<EntityCubit>()
                                .searchEntities,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'search_placeholder'.tr(),
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: () {
                    if (state is EntityLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is EntityLoaded) {
                      if (state.entities.isEmpty) {
                        return Center(
                          child: Text("There is no medical entity"),
                        ); // Empty state message
                      }

                      return ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemCount: state.entities.length,
                        itemBuilder: (context, index) {
                          final entity = state.entities[index];
                          return MedicalCard(
                            medicalEntity: entity,
                            isBooking: widget.isBooking,
                          );
                        },
                      );
                    } else if (state is EntityFailure) {
                      return Center(child: Text(state.message));
                    } else {
                      return SizedBox.shrink();
                    }
                  }(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
