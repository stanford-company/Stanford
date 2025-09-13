import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medapp/core/constants/app_colors.dart';
import 'package:medapp/presentation/medical_entity/pages/step2/choose_doctor_page.dart';
import '../../../../core/routes/routes.dart';
import '../../../common/components/arrow_back_widget.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/category/model/category.dart';
import '../../../data/cities_network/model/city.dart';
import '../../../domain/city_network/usecase/city_usecase.dart';
import '../../main_home/widgets/nav_bar_item_widget.dart';
import '../bloc/city_network_cubit.dart';
import '../bloc/city_network_state.dart';

class CityNetworkPage extends StatefulWidget {
  final int categoryId;

  const CityNetworkPage({super.key, required this.categoryId});

  @override
  State<CityNetworkPage> createState() => _CityNetworkPageState();
}

class _CityNetworkPageState extends State<CityNetworkPage> {
  bool isDrawerOpen = false;
  int _selectedIndex = 2;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    // Fetch category from navigation arguments
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

    return BlocProvider(
      create: (context) =>
          CityNetworkCubit(getIt<GetCitiesNetworkUsecase>())
            ..fetchCities(), // Pass GetCitiesNetworkUsecase to CityNetworkCubit
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
                  leading: ArrowBackWidget(),
                  title: Text(
                    "choose_city".tr(),
                    style: TextStyle(color: Color(0xff113f4e)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<CityNetworkCubit, CityNetworkState>(
          builder: (context, state) {
            if (state is CityNetworkLoaded) {
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
                                    onChanged: context
                                        .read<CityNetworkCubit>()
                                        .searchCities,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search for cities...',
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
                        itemCount: state
                            .cities
                            .length, // Use filtered list or all cities
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
                              context
                                  .read<CityNetworkCubit>()
                                  .toggleCitySelection(city.id.toString());
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
                                            .read<CityNetworkCubit>()
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseDoctorPage(
                                    cityId: state.cityId,
                                    isBooking: false,
                                    categoryId: widget.categoryId,
                                  ),
                                ),
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
            } else if (state is CityNetworkLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CityNetworkError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
