import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_button.dart';
import '../../routes/routes.dart';
import 'widgets/input_widget.dart';
import 'widgets/social_login_widget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';

    return Scaffold(
      backgroundColor: Color(0xff0c3c4c),
      body: Column(
        children: [
          // Fixed Header
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF0C3C4C),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 100.h, right: 8.w, left: 8.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Image.asset(
                      'assets/images/launcher_ic-white.png',
                      height: 60.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 40.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.5.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.setLocale(Locale('en'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isEnglish ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                    color: isEnglish ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.setLocale(Locale('ar'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: !isEnglish ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'العربية',
                                  style: TextStyle(
                                    color: !isEnglish ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
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
          ),

          // Scrollable content
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.h),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0C3C4C),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Log in to your Stanford account',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        InputWidget(),
                        SizedBox(height: 20.h),
                        CustomButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(Routes.home);
                          },
                          text: 'Login',
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: Wrap(
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Color(0xffbcbcbc),
                                  fontSize: 14.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(Routes.signup);
                                },
                                child: Text(
                                  'Register now',
                                  style: TextStyle(
                                    color: Color(0xFF1b8064),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
