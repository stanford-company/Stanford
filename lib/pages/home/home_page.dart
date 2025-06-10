import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/model/medical_centers.dart';
import 'package:medapp/pages/home/widgets/search_slider_widget.dart';

import '../../../presentation/ads/bloc/ads_cubit.dart';
import '../../common/components/medical_authorities_list_item.dart';
import '../../common/components/medical_center_list_item.dart';
import '../../../model/doctor.dart';
import '../../core/routes/routes.dart';
import '../../presentation/ads/pages/search_slider_widget.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final bool _noAppoints = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _noAppoints
                ? NoAppointmentsWidget()
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// ✅ Wrap MedicalSearchWidget with BlocProvider
                BlocProvider(
                  create: (_) => AdsCubit()..fetchAdsFromSharedPreferences(),
                  child: MedicalSearchWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: SectionHeaderWidget(
                    title: 'next_appointment'.tr(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: NextAppointmentWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: SectionHeaderWidget(
                    title: 'Medical authorities'.tr(),
                    onPressed: () => Navigator.of(
                      context,
                    ).pushNamed(Routes.myDoctors),
                  ),
                ),
              ],
            ),
            Container(
              height: 160,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 15.w),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return MedicalAuthoritiesListItem(
                    doctor: doctors[index],
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: SectionHeaderWidget(
                    title: 'medical_centers'.tr(),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 160,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 15),
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      return MedicalCentersListItem(
                        medicalCenter: medicalCenter[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
