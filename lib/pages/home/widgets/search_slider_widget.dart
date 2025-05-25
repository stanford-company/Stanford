import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalSearchWidget extends StatefulWidget {
  const MedicalSearchWidget({Key? key}) : super(key: key);

  @override
  State<MedicalSearchWidget> createState() => _MedicalSearchWidgetState();
}

class _MedicalSearchWidgetState extends State<MedicalSearchWidget> {
  int _currentIndex = 0;

  final List<Widget> _carouselItems = [
    const BannerItem(),
    const BannerItem(),
    const BannerItem(),
    const BannerItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  print("Filter button clicked");
                },
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

        SizedBox(
          height: 250.h,
          child: Column(
            children: [
              CarouselSlider(
                items: _carouselItems,
                options: CarouselOptions(
                  height: 200.h,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    if (mounted) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _carouselItems.length,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: index == _currentIndex ? 30.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? const Color(0xff1b8064)
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BannerItem extends StatelessWidget {
  const BannerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h, // Match this height with CarouselSlider height
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/Ad Container.png'),
          fit: BoxFit.cover, // Ensure image fills the container
        ),
      ),
    );
  }
}

