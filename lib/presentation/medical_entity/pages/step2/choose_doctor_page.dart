import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medapp/common/components/medical_card.dart';
import 'package:medapp/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../common/components/custom_navigation_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../pages/home/widgets/nav_bar_item_widget.dart';
import '../../bloc/entity_cubit.dart';

class ChooseDoctorPage extends StatefulWidget {
  final String cityId;

  const ChooseDoctorPage({super.key, required this.cityId});

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
      create: (_) =>
          EntityCubit()..getEntities(cityId: int.parse(widget.cityId)),
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
                      return ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemCount: state.entities.length,
                        itemBuilder: (context, index) {
                          final entity = state.entities[index];
                          return MedicalCard(medicalEntity: entity);
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

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff113f4e),
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: CustomNavigationBar(
              backgroundColor: Colors.transparent,
              strokeColor: Colors.transparent,
              items: [
                NavBarItemWidget(
                  onTap: () => Navigator.pushNamed(context, Routes.home),
                  image: 'assets/images/svg/home-nav-bar.svg',
                  label: 'home'.tr(),
                  isSelected: _selectedIndex == 0,
                ),
                NavBarItemWidget(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.bookingStep3),
                  image: 'assets/images/svg/calendar-nav-bar.svg',
                  label: 'booked'.tr(),
                  isSelected: _selectedIndex == 1,
                ),
                NavBarItemWidget(
                  onTap: () => Navigator.of(context).pop(),
                  image: 'assets/images/svg/appointment-nav-bar.svg',
                  label: 'book_now'.tr(),
                  isSelected: _selectedIndex == 2,
                ),
                NavBarItemWidget(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.appointmentDetail),
                  image: 'assets/images/svg/bag-nav-bar.svg',
                  label: 'store'.tr(),
                  isSelected: _selectedIndex == 3,
                ),
                NavBarItemWidget(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.notificationSettings),
                  image: 'assets/images/svg/menu-nav-bar.svg',
                  label: 'settings'.tr(),
                  isSelected: _selectedIndex == 4,
                ),
              ],
              currentIndex: _selectedIndex,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
