import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medapp/core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../common/components/custom_navigation_bar.dart';
import '../../../data/category/model/category.dart';
import '../../../pages/home/widgets/nav_bar_item_widget.dart';
import '../bloc/city_cubit.dart';
import '../bloc/city_state.dart';

class CityPage extends StatefulWidget {
  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  bool isDrawerOpen = false;
  int _selectedIndex = 2;
  late PageController _pageController;
  CategoryModel? _category;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rawCategory = ModalRoute.of(context)?.settings.arguments;
      setState(() {
        _category = rawCategory is CategoryModel
            ? rawCategory
            : rawCategory is Map<String, dynamic>
            ? CategoryModel.fromJson(rawCategory)
            : null;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _selectPage(int index) {
    if (_pageController.hasClients) _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rawCategory = ModalRoute.of(context)!.settings.arguments;

    final category = rawCategory is CategoryModel
        ? rawCategory
        : rawCategory is Map<String, dynamic>
        ? CategoryModel.fromJson(rawCategory)
        : null;

    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => CityCubit()..getCities(),
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
                    icon: Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/svg/arrow_back.svg',
                        width: 45.w,
                        height: 45.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    "Book an appointment",
                    style: TextStyle(color: Color(0xff113f4e)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<CityCubit, CityState>(
          builder: (context, state) {
            if (state is CityLoaded) {
              return Column(
                children: [
                  SizedBox(height: 12.h),
                  Divider(thickness: 1.2.h, color: Color(0xffEAECF0)),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                                      hintText:
                                          'Search for clinics, doctors, hospitals',
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Choose City',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff113f4e),
                              fontSize: 16.sp,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: GridView.builder(
                        itemCount: state.cities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (context, index) {
                          final city = state.cities[index];
                          final isSelected = state.cityId == city.id.toString();
                          return InkWell(
                            onTap: () {
                              context.read<CityCubit>().toggleCitySelection(
                                city.id.toString(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.secondary_color
                                      : AppColors.bold_grey_color,
                                  width: isSelected ? 3.w : 1.w,
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                                color: Color(0xfff3f3f6),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4.r,
                                          ),
                                        ),
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                              (states) {
                                                if (states.contains(
                                                  MaterialState.selected,
                                                )) {
                                                  return BorderSide(
                                                    color: AppColors
                                                        .secondary_color,
                                                    width: 2,
                                                  );
                                                }
                                                return BorderSide(
                                                  color: isSelected
                                                      ? AppColors
                                                            .secondary_color
                                                      : AppColors
                                                            .bold_grey_color,
                                                  width: isSelected ? 3.w : 2.w,
                                                );
                                              },
                                            ),
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((states) {
                                              return states.contains(
                                                    MaterialState.selected,
                                                  )
                                                  ? AppColors.secondary_color
                                                  : Colors.transparent;
                                            }),
                                        checkColor:
                                            MaterialStateProperty.all<Color>(
                                              AppColors.primary_color,
                                            ),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity(
                                          horizontal: -2,
                                          vertical: -2,
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (_) {
                                        context
                                            .read<CityCubit>()
                                            .toggleCitySelection(
                                              city.id.toString(),
                                            );
                                      },
                                    ),
                                  ),
                                  Text(
                                    city.nameEn,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: state.cityId.isNotEmpty
                          ? () {
                              Navigator.pushNamed(
                                context,
                                Routes.bookingStep2,
                                arguments: state.cityId,
                              );
                            }
                          : null,

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                        backgroundColor: state.cityId.isNotEmpty
                            ? AppColors.primary_button_color
                            : AppColors.light_grey_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              color: AppColors.white_text_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            } else if (state is CityLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CityFailure) {
              return Center(child: Text(state.message));
            } else {
              return SizedBox.shrink();
            }
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
                  onTap: () {
                    Navigator.pushNamed(context, Routes.home);
                  },
                  image: 'assets/images/svg/home-nav-bar.svg',
                  label: 'Home',
                  isSelected: _selectedIndex == 0,
                ),
                NavBarItemWidget(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.bookingStep3);
                  },
                  image: 'assets/images/svg/calendar-nav-bar.svg',
                  label: 'Booked',
                  isSelected: _selectedIndex == 1,
                ),
                NavBarItemWidget(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  image: 'assets/images/svg/appointment-nav-bar.svg',
                  label: 'Book now',
                  isSelected: _selectedIndex == 2,
                ),
                NavBarItemWidget(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.appointmentDetail);
                  },
                  image: 'assets/images/svg/bag-nav-bar.svg',
                  label: 'Store',
                  isSelected: _selectedIndex == 3,
                ),
                NavBarItemWidget(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.notificationSettings);
                  },
                  image: 'assets/images/svg/menu-nav-bar.svg',
                  label: 'Settings',
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
