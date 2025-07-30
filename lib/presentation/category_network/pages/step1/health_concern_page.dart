import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:medapp/data/category_network/model/category.dart';
import 'package:medapp/presentation/category_network/bloc/category_network_cubit.dart';
import '../../../../core/routes/routes.dart';

class CategoryNetworkPage extends StatefulWidget {
  @override
  State<CategoryNetworkPage> createState() => _CategoryNetworkPageState();
}

class _CategoryNetworkPageState extends State<CategoryNetworkPage> {
  List<CategoryNetworkModel> allCategories = [];
  List<CategoryNetworkModel> filteredCategories = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    final isArabic = context.locale.languageCode == 'ar';
    setState(() {
      filteredCategories = allCategories.where((cat) {
        final name = isArabic ? cat.nameAr : cat.nameEn;
        return name?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  Future<void> saveToPrefs(List<CategoryNetworkModel> data) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(data.map((e) => e.toJson()).toList());
    await prefs.setString('category_network', encoded);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryNetworkCubit()..getNetworkCategories(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 60.h,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/launcher_ic.png',
                  height: 50.h,
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<CategoryNetworkCubit, CategoryNetworkState>(
          builder: (context, state) {
            if (state is CategoryNetworkLoaded) {
              allCategories = state.categories;
              if (filteredCategories.isEmpty) filteredCategories = allCategories;
              saveToPrefs(allCategories); // ✅ Save to SharedPreferences
              final isArabic = context.locale.languageCode == 'ar';

              return Column(
                children: [
                  SizedBox(height: 12.h),
                  Divider(thickness: 1.2.h, color: const Color(0xffEAECF0)),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search for clinics, doctors, hospitals',
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
                        itemCount: filteredCategories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.8,
                        ),
                        itemBuilder: (context, index) {
                          final category = filteredCategories[index];
                          final categoryName = isArabic
                              ? category.nameAr ?? "بدون اسم"
                              : category.nameEn ?? "Unnamed";

                          return GestureDetector(
                            onTap: () {
                              // Navigate to City Network Page on tap
                              Navigator.pushNamed(
                                context,
                                Routes.bookingStepCityNetwork,  // Assuming this is your route name for CityNetworkPage
                                arguments: category.id,  // Pass the selected category
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xffF2F4F7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.teal.shade100,
                                    child: SvgPicture.asset(
                                      'assets/images/svg/major_icon.svg',
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      categoryName,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
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
            } else if (state is CategoryNetworkFailure) {
              return Center(child: Text('Failed: ${state.message}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
