import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:medapp/presentation/main_home/widgets/nav_bar_item_widget.dart';
import '../../../common/components/custom_navigation_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../cart/bloc/cart_cubit.dart';
import '../../cart/pages/cart_view.dart';

import '../../auth/pages/drawer_page.dart';
import '../../appointments_history/pages/booked_page.dart';
import '../../category/pages/step1/health_concern_page.dart';
import '../../store/pages/stroe_page.dart';
import '../../settings/pages/settings_page.dart';
import '../../home/pages/home_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  int _selectedIndex = 0;

  late PageController _pageController;

  Future<bool> _showExitConfirmationDialog() async {
    print("Exit confirmation dialog called"); // Debug print

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'exit_app'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C3C4C),
              fontSize: 18.sp,
            ),
          ),
          content: Text(
            'are_you_sure_you_want_to_exit'.tr(),
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                print("Cancel pressed");
                Navigator.of(context).pop(false);
              },
              child: Text(
                'cancel'.tr(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                print("Exit pressed");
                Navigator.of(context).pop(true);
              },
              child: Text(
                'exit'.tr(),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    print("Dialog result: $result"); // Debug print

    if (result == true) {
      print("Closing app"); // Debug print
      SystemNavigator.pop();
    }

    return false; // Always prevent default back behavior
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
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
    final size = MediaQuery.of(context).size;
    final _pages = [
      HomePage(),
      BookedPage(),
      HealthConcernPage(),
      StorePage(),
      SettingsPage(),
    ];
    final _titles = [
      'home'.tr(),
      'booked'.tr(),
      'book_now'.tr(),
      'store'.tr(),
      'settings'.tr(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          print('PopScope triggered at top level - about to show exit dialog');
          final shouldPop = await _showExitConfirmationDialog();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            DrawerPage(
              onTap: () {
                setState(() {
                  xOffset = 0;
                  yOffset = 0;
                  scaleFactor = 1;
                  isDrawerOpen = false;
                });
              },
            ),
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor)
                ..rotateY(isDrawerOpen ? -0.5 : 0),
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isDrawerOpen ? 40.w : 0.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 40.w : 0.0),
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(92.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        children: [
                          SizedBox(height: 32.h),
                          AppBar(
                            elevation: 0,
                            automaticallyImplyLeading: false,
                            toolbarHeight: 60.h,
                            leading: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/images/svg/drawer_icon.svg',
                                  width: isDrawerOpen ? 24.w : 45.w,
                                  height: isDrawerOpen ? 24.h : 45.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isDrawerOpen) {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  } else {
                                    xOffset = size.width - size.width / 3;
                                    yOffset = size.height * 0.1;
                                    scaleFactor = 0.8;
                                    isDrawerOpen = true;
                                  }
                                });
                              },
                            ),
                            centerTitle: true,
                            title: Text(
                              _titles[_selectedIndex],
                              style: TextStyle(
                                color: Color(0xff113f4e),
                                fontSize: 18.sp,
                              ),
                            ),
                            actions: <Widget>[
                              _selectedIndex == 2
                                  ? IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Container(
                                        width: 60.w,
                                        height: 60.h,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: 24.sp,
                                        ),
                                      ),
                                      onPressed: () {},
                                    )
                                  : SizedBox(),
                              _selectedIndex == 3
                                  ? BlocBuilder<CartCubit, CartState>(
                                      builder: (context, cartState) {
                                        int itemCount = 0;
                                        if (cartState is CartLoaded) {
                                          itemCount = cartState.items.fold<int>(
                                            0,
                                            (sum, item) =>
                                                sum +
                                                (item['quantity'] as int? ?? 0),
                                          );
                                        }

                                        return Stack(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const CartPage(
                                                          phone: "0799999999",
                                                        ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.shopping_cart_outlined,
                                                size: 26.w,
                                                color: AppColors.primary_color,
                                              ),
                                            ),
                                            if (itemCount > 0)
                                              Positioned(
                                                right: 6,
                                                top: 6,
                                                child: Container(
                                                  padding: EdgeInsets.all(2.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.r,
                                                        ),
                                                  ),
                                                  constraints: BoxConstraints(
                                                    minWidth: 18.w,
                                                    minHeight: 18.h,
                                                  ),
                                                  child: Text(
                                                    itemCount > 99
                                                        ? '99+'
                                                        : itemCount.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    )
                                  : SizedBox(),
                              // IconButton(
                              //         padding: EdgeInsets.zero,
                              //         icon: Container(
                              //           width: 60.w,
                              //           height: 60.h,
                              //           alignment: Alignment.center,
                              //           child: SvgPicture.asset(
                              //             'assets/images/svg/notifications_icon.svg',
                              //             width: 45.w,
                              //             height: 45.h,
                              //             fit: BoxFit.contain,
                              //           ),
                              //         ),
                              //         onPressed: () => Navigator.pushNamed(
                              //           context,
                              //           Routes.notifications,
                              //         ),
                              //       ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: _pages,
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      bottom: 12.h,
                    ),
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
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w,
                      ),
                      child: CustomNavigationBar(
                        backgroundColor: Colors.transparent,
                        strokeColor: Colors.transparent,
                        items: [
                          NavBarItemWidget(
                            onTap: () => _selectPage(0),
                            image: 'assets/images/svg/home-nav-bar.svg',
                            label: 'home'.tr(),
                            isSelected: _selectedIndex == 0,
                          ),
                          NavBarItemWidget(
                            onTap: () => _selectPage(1),
                            image: 'assets/images/svg/calendar-nav-bar.svg',
                            label: 'booked'.tr(),
                            isSelected: _selectedIndex == 1,
                          ),
                          NavBarItemWidget(
                            onTap: () => _selectPage(2),
                            image: 'assets/images/svg/appointment-nav-bar.svg',
                            label: 'book_now'.tr(),
                            isSelected: _selectedIndex == 2,
                          ),
                          NavBarItemWidget(
                            onTap: () => _selectPage(3),
                            image: 'assets/images/svg/bag-nav-bar.svg',
                            label: 'store'.tr(),
                            isSelected: _selectedIndex == 3,
                          ),
                          NavBarItemWidget(
                            onTap: () => _selectPage(4),
                            image: 'assets/images/svg/menu-nav-bar.svg',
                            label: 'settings'.tr(),
                            isSelected: _selectedIndex == 4,
                          ),
                        ],
                        currentIndex: _selectedIndex,
                        elevation: 0,
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
