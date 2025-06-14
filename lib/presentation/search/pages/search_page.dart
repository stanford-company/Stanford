import 'dart:math';

import 'package:easy_localization/easy_localization.dart'
    show tr, StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medapp/presentation/ads/pages/search_slider_widget.dart';
import 'package:medapp/presentation/search/bloc/search_cubit.dart';

import '../../../common/components/medical_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../../pages/home/widgets/app_bar_title_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 60.h,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: AppBarTitleWidget(),
        ),
        body: Column(
          children: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => print("Filter button clicked"),
                        child: Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xff13434A),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/svg/IC_Filter.svg',
                              width: 24.w,
                              height: 24.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                                  textDirection: TextDirection.rtl,
                                  onSubmitted: (value) async {
                                    await context
                                        .read<SearchCubit>()
                                        .medicalSearch(name: value);
                                  },
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
                );
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is SearchLoaded)
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(16.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemCount: state.medicalEntity.length,
                      itemBuilder: (context, index) {
                        return MedicalCard(
                          medicalEntity: state.medicalEntity[index],
                        );
                      },
                    ),
                  );
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
