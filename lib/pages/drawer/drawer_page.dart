import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocks/logout/logout_bloc.dart';
import '../../routes/routes.dart';
import '../../utils/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/shared_prefs_service.dart';

class DrawerPage extends StatelessWidget {
  final void Function() onTap;

  const DrawerPage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Scaffold(
        backgroundColor: kColorPrimary,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 35.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.grey,
                        backgroundImage: const AssetImage(
                          'assets/images/icon_man.png',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: <Widget>[
                          Text(
                            'Tawfiq Bahri',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'O+',
                            style: TextStyle(
                              color: kColorSecondary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                _drawerItem(
                  context: context,
                  image: 'person',
                  text: 'my_doctors',
                  onTap: () => Navigator.of(context).pushNamed(Routes.myDoctors),
                ),
                _drawerItem(
                  context: context,
                  image: 'calendar',
                  text: 'my_appointments',
                  onTap: () => Navigator.of(context).pushNamed(Routes.myAppointments),
                ),
                _drawerItem(
                  context: context,
                  image: 'hospital',
                  text: 'hospitals',
                  onTap: () {},
                ),
                _drawerItem(
                  context: context,
                  image: 'hospital',
                  text: 'Logout',
                  onTap: () async {
                    final token = await SharedPrefsService.getToken();
                    if (token == null || token.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No active session found'.tr())),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider(
                        create: (context) => LogoutBloc(
                          ApiService(),
                          SharedPrefsService(),
                        ),
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
                                  : Text('Are you sure you want to logout?'.tr()),
                              actions: [
                                if (state is! LogoutInProgress)
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
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
                                          : Theme.of(context).errorColor,
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
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required String image,
    required String text,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        height: 58.h,
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/$image.png',
              color: Colors.white,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 10.w),
            Text(
              text.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}