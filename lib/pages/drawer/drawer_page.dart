import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/routes/routes.dart';
import '../../blocks/logout/logout_bloc.dart';
import '../../core/utils/api_service.dart';
import '../../core/utils/shared_prefs_service.dart';

class DrawerPage extends StatefulWidget {
  final void Function() onTap;

  const DrawerPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String selectedItem = 'home'; // Use localization key

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Scaffold(
        body: Container(
          color: const Color(0xff13434a),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 90.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _drawerItem(
                    label: 'home',
                    icon: 'home-drawer-icon',
                    isSelected: selectedItem == 'home',
                    onTap: () {
                      setState(() => selectedItem = 'home');
                      Navigator.of(context).pushNamed(Routes.myDoctors);
                    },
                  ),
                  _drawerItem(
                    label: 'medical_network',
                    icon: 'medical-authorities-drawer-icon',
                    isSelected: selectedItem == 'medical_network',
                    onTap: () => setState(() => selectedItem = 'medical_network'),
                  ),
                  _drawerItem(
                    label: 'guidelines_list',
                    icon: 'instructions-drawer-icon',
                    isSelected: selectedItem == 'guidelines_list',
                    onTap: () => setState(() => selectedItem = 'guidelines_list'),
                  ),
                  _divider(),
                  _drawerItem(
                    label: 'contact_us',
                    icon: 'contact-us-drawer-icon',
                    isSelected: selectedItem == 'contact_us',
                    onTap: () => setState(() => selectedItem = 'contact_us'),
                  ),
                  _drawerItem(
                    label: 'complaints_suggestions',
                    icon: 'suggestions-drawer-icon',
                    isSelected: selectedItem == 'complaints_suggestions',
                    onTap: () => setState(() => selectedItem = 'complaints_suggestions'),
                  ),
                  _divider(),
                  _drawerItem(
                    label: 'profile',
                    icon: 'profile-drawer-icon',
                    isSelected: selectedItem == 'profile',
                    onTap: () => setState(() => selectedItem = 'profile'),
                  ),
                  _drawerItem(
                    label: 'settings',
                    icon: 'setting-drawer-icon',
                    isSelected: selectedItem == 'settings',
                    onTap: () => setState(() => selectedItem = 'settings'),
                  ),
                  _divider(),
                  _drawerItem(
                    label: 'logout',
                    icon: 'logout-drawer-icon',
                    isSelected: selectedItem == 'logout',
                    onTap: () async {
                      setState(() => selectedItem = 'logout');
                      final token = await SharedPrefsService.getToken();
                      if (token == null || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('no_active_session'.tr())),
                        );
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider(
                          create: (context) => LogoutBloc(ApiService(), SharedPrefsService()),
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
                                title: Text('logout'.tr()),
                                content: state is LogoutInProgress
                                    ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16.h),
                                    Text('logging_out'.tr()),
                                  ],
                                )
                                    : Text('logout_confirmation'.tr()),
                                actions: [
                                  if (state is! LogoutInProgress)
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text('cancel'.tr()),
                                    ),
                                  TextButton(
                                    onPressed: state is LogoutInProgress
                                        ? null
                                        : () => context.read<LogoutBloc>().add(LogoutRequested(token)),
                                    child: Text(
                                      'logout'.tr(),
                                      style: TextStyle(
                                        color: state is LogoutInProgress
                                            ? Colors.grey
                                            : Theme.of(context).colorScheme.error,
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
    required String label,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color selectedColor = const Color(0xff13434a);
    final Color unselectedColor = Colors.white;

    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 175.w,
          margin: EdgeInsets.symmetric(vertical: 4.h),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
          decoration: isSelected
              ? BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
          )
              : null,
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/$icon.svg',
                width: 22.w,
                height: 22.h,
                color: isSelected ? selectedColor : unselectedColor,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Divider(
        color: Colors.white24,
        thickness: 1,
        indent: 1.w,
        endIndent: 0.w,
      ),
    );
  }
}
