import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/core/constants/app_colors.dart';
import 'package:medapp/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:medapp/common/components/basic_app_button.dart';
import 'package:medapp/common/components/language_switcher_widget.dart';
import 'package:medapp/core/routes/routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingPageChanged) {
                pageController.animateToPage(
                  state.currentIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else if (state is OnboardingCompleted ||
                  state is OnboardingSkipped) {
                Navigator.of(context).pushReplacementNamed(Routes.login);
              }
            },
            builder: (context, state) {
              final cubit = context.read<OnboardingCubit>();

              return Column(
                children: [
                  // Skip button and language switcher
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const LanguageSwitcherWidget(
                          backgroundColor: Color(0xFFF0F0F0),
                          activeColor: Color(0xFF0C3C4C),
                          inactiveColor: Colors.transparent,
                          activeTextColor: Colors.white,
                          inactiveTextColor: Color(0xFF666666),
                        ),
                        TextButton(
                          onPressed: () => cubit.skipOnboarding(),
                          child: Text(
                            'skip'.tr(),
                            style: TextStyle(
                              color: AppColors.primary_color,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // PageView
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) => cubit.goToPage(index),
                      children: [
                        _buildOnboardingPage(
                          image: 'assets/images/onboarding_one.png',
                          title: 'onboarding_title_1'.tr(),
                          subtitle: 'onboarding_subtitle_1'.tr(),
                          index: 0,
                        ),
                        _buildOnboardingPage(
                          image: 'assets/images/onboarding_two.png',
                          title: 'onboarding_title_2'.tr(),
                          subtitle: 'onboarding_subtitle_2'.tr(),
                          index: 1,
                        ),
                        _buildOnboardingPage(
                          image: 'assets/images/onboarding_three.png',
                          title: 'onboarding_title_3'.tr(),
                          subtitle: 'onboarding_subtitle_3'.tr(),
                          index: 2,
                        ),
                      ],
                    ),
                  ),

                  // Page indicators
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          width: cubit.currentIndex == index ? 24.w : 8.w,
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == index
                                ? AppColors.primary_color
                                : AppColors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      children: [
                        BasicAppButton(
                          text: cubit.currentIndex == 2
                              ? 'get_started'.tr()
                              : 'next'.tr(),
                          onTap: () => cubit.nextPage(),
                        ),
                        SizedBox(height: 12.h),
                        if (cubit.currentIndex > 0)
                          TextButton(
                            onPressed: () => cubit.previousPage(),
                            child: Text(
                              'previous'.tr(),
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String subtitle,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        children: [
          // Image positioned at the top
          Positioned(
            top: 0,
            left: index == 0 ? 0 : 40.w,
            right: index == 0 ? 0 : 40.w,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.light_grey_color,
                      child: Icon(
                        Icons.image,
                        size: 100.sp,
                        color: AppColors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Title positioned below the image
          Positioned(
            top: 300.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary_color,
                    height: 1.3,
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Subtitle positioned at the bottom
        ],
      ),
    );
  }
}
