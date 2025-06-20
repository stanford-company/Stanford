import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medapp/presentation/main_home/widgets/app_bar_title_widget.dart';
import 'package:medapp/presentation/main_home/widgets/nav_bar_item_widget.dart';
import '../../common/components/custom_navigation_bar.dart';
import '../../core/routes/routes.dart';
import '../auth/pages/drawer_page.dart';
import '../booked/pages/booked_page.dart';
import '../category/pages/step1/health_concern_page.dart';
import '../store/pages/stroe_page.dart';
import '../settings/pages/settings_page.dart';
import '../home/pages/home_page.dart';

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                          title: AppBarTitleWidget(),
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
                                : IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Container(
                                      width: 60.w,
                                      height: 60.h,
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        'assets/images/svg/notifications_icon.svg',
                                        width: 45.w,
                                        height: 45.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      Routes.notifications,
                                    ),
                                  ),
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
                          label: 'Home',
                          isSelected: _selectedIndex == 0,
                        ),
                        NavBarItemWidget(
                          onTap: () => _selectPage(1),
                          image: 'assets/images/svg/calendar-nav-bar.svg',
                          label: 'Booked',
                          isSelected: _selectedIndex == 1,
                        ),
                        NavBarItemWidget(
                          onTap: () => _selectPage(2),
                          image: 'assets/images/svg/appointment-nav-bar.svg',
                          label: 'Book now',
                          isSelected: _selectedIndex == 2,
                        ),
                        NavBarItemWidget(
                          onTap: () => _selectPage(3),
                          image: 'assets/images/svg/bag-nav-bar.svg',
                          label: 'Store',
                          isSelected: _selectedIndex == 3,
                        ),
                        NavBarItemWidget(
                          onTap: () => _selectPage(4),
                          image: 'assets/images/svg/menu-nav-bar.svg',
                          label: 'Settings',
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
    );
  }
}
