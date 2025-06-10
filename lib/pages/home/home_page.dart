import 'dart:math';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/model/medical_centers.dart';
import 'package:medapp/pages/home/widgets/search_slider_widget.dart';

import '../../../presentation/ads/bloc/ads_cubit.dart'; // Make sure the AdsCubit is imported
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

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>, TickerProviderStateMixin {
  final bool _noAppoints = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  Future<void> _refreshData() async {
    context.read<AdsCubit>().fetchAdsFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
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
                      onPressed: () => Navigator.of(context).pushNamed(Routes.myDoctors),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomRingPainter extends CustomPainter {
  final double angle;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  CustomRingPainter({
    required this.angle,
    this.backgroundColor = Colors.lightGreen,
    this.progressColor = Colors.teal,
    this.strokeWidth = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Light green circular background
    final backgroundPaint = Paint()
      ..color = backgroundColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Teal rotating arc
    final foregroundPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = pi / 2.5;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      angle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomRingPainter oldDelegate) =>
      oldDelegate.angle != angle;
}

class CustomCircularRefreshIndicator extends StatelessWidget {
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  CustomCircularRefreshIndicator({
    this.backgroundColor = Colors.lightGreen,
    this.progressColor = Colors.teal,
    this.strokeWidth = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
        double angle = 0;
        if (state is AdsLoading) {
          angle = pi / 2.5;
        }

        return CustomPaint(
          painter: CustomRingPainter(
            angle: angle,
            backgroundColor: backgroundColor,
            progressColor: progressColor,
            strokeWidth: strokeWidth,
          ),
          child: SizedBox(width: 50, height: 50),
        );
      },
    );
  }
}
