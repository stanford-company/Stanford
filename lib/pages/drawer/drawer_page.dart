import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/routes/routes.dart';
import '../../../core/utils/constants.dart';
import '../../blocks/logout/logout_bloc.dart';
import '../../core/utils/api_service.dart';
import '../../core/utils/shared_prefs_service.dart';

class DrawerPage extends StatelessWidget {
  final void Function() onTap;

  const DrawerPage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff13434a),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 35.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30.h),
                  _drawerItem(
                    context: context,
                    image: 'home-drawer-icon',
                    text: 'Home',
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.myDoctors),
                    iconColor: Color(0xff113f4e),
                    textColor: Color(0xff113f4e),
                  ),
                  SizedBox(height: 16.h),
                  _drawerItem(
                    context: context,
                    image: 'person',
                    text: 'my_doctors',
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.myDoctors),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                  ),
                  _drawerItem(
                    context: context,
                    image: 'calendar',
                    text: 'my_appointments',
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.myAppointments),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                  ),
                  _drawerItem(
                    context: context,
                    image: 'hospital',
                    text: 'hospitals',
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                  _drawerItem(
                    context: context,
                    image: 'hospital',
                    text: 'Logout',
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () async {
                      final token = await SharedPrefsService.getToken();
                      if (token == null || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No active session found'.tr()),
                          ),
                        );
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              LogoutBloc(ApiService(), SharedPrefsService()),
                          child: BlocConsumer<LogoutBloc, LogoutState>(
                            listener: (context, state) {
                              if (state is LogoutSuccess) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.login,
                                  (route) => false,
                                );
                              } else if (state is LogoutFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)),
                                );
                                Navigator.of(context).pop();
                              }
                            },
                            builder: (context, state) {
                              return AlertDialog(
                                title: Text('Logout'.tr()),
                                content: state is LogoutInProgress
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 16.h),
                                          Text('Logging out...'.tr()),
                                        ],
                                      )
                                    : Text(
                                        'Are you sure you want to logout?'.tr(),
                                      ),
                                actions: [
                                  if (state is! LogoutInProgress)
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('CANCEL'.tr()),
                                    ),
                                  TextButton(
                                    onPressed: state is LogoutInProgress
                                        ? null
                                        : () => context.read<LogoutBloc>().add(
                                            LogoutRequested(token),
                                          ),
                                    child: Text(
                                      'LOGOUT'.tr(),
                                      style: TextStyle(
                                        color: state is LogoutInProgress
                                            ? Colors.grey
                                            : Theme.of(
                                                context,
                                              ).colorScheme.error,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required String image,
    required String text,
    required VoidCallback onTap,
    required Color iconColor,
    required Color textColor,
  }) {
    final isHome = image == 'home-drawer-icon';

    final content = Row(
      children: [
        SvgPicture.asset(
          'assets/images/svg/$image.svg',
          width: 24.w,
          height: 24.h,
          color: iconColor,
        ),
        SizedBox(width: 12.w),
        Text(
          text.tr(), // Add translation if needed
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    return InkWell(
      onTap: onTap,
      child: isHome
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: content,
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
              child: content,
            ),
    );
  }
}
