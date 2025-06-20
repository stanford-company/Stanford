import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medapp/common/components/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../presentation/ads/bloc/ads_cubit.dart';

class MedicalSearchWidget extends StatefulWidget {
  const MedicalSearchWidget({Key? key}) : super(key: key);

  @override
  State<MedicalSearchWidget> createState() => _MedicalSearchWidgetState();
}

class _MedicalSearchWidgetState extends State<MedicalSearchWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AdsCubit>().fetchAdsFromSharedPreferences();
  }

  Future<void> _loadAndFetchAds() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null && context.mounted) {
      context.read<AdsCubit>().fetchAds(token);
    } else {
      debugPrint("⚠️ Token not found in SharedPreferences.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Search + Filter UI
        SearchWidget(),

        /// Ads Carousel
        SizedBox(
          height: 250.h,
          child: BlocBuilder<AdsCubit, AdsState>(
            builder: (context, state) {
              if (state is AdsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdsLoaded) {
                final List<String> imageUrls = state.ads.ads
                    .map((ad) => ad.imageUrl)
                    .toList();
                return Column(
                  children: [
                    CarouselSlider(
                      items: imageUrls
                          .map(
                            (url) => Image.network(
                              url,
                              width: double.infinity,
                              height: 200.h,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 200.h,
                        viewportFraction: 1.0,
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
                        imageUrls.length,
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
                );
              } else if (state is AdsError) {
                return Center(child: Text("Failed to load ads"));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
