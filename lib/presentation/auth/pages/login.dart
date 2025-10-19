import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/routes/routes.dart';
import '../../../common/components/language_switcher_widget.dart';
import '../bloc/login_cubit.dart';
import '../widgets/input_widget.dart'; // Import cubit

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c3c4c),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Column(
          children: [
            // Header
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xFF0C3C4C)),
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
                    const LanguageSwitcherWidget(),
                  ],
                ),
              ),
            ),

            // Content
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
                                  'log_in'.tr(),
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0C3C4C),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'log_in_to_your_stanford_account'.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          LoginInputWidget(), // Use your cubit-based input widget here
                          SizedBox(height: 20.h),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  'dont_have_an_account'.tr(),
                                  style: TextStyle(
                                    color: Color(0xffbcbcbc),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(Routes.signup);
                                  },
                                  child: Text(
                                    'register_now'.tr(),
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
      ),
    );
  }
}
