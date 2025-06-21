import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medapp/common/components/search_widget.dart';

import '../../../common/components/medical_card.dart';
import '../../../data/medical_entity/model/medical_doctor.dart';
import '../../main_home/widgets/app_bar_title_widget.dart';
import '../../search/bloc/search_cubit.dart';

class AllMedicalsPage extends StatelessWidget {
  final List<MedicalModel> medicalDoctors;
  const AllMedicalsPage({super.key, required this.medicalDoctors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 60.h,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: AppBarTitleWidget(),
      ),
      body: Column(
        children: [
          SearchWidget(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: medicalDoctors.length,
              itemBuilder: (context, index) {
                return MedicalCard(medicalModel: medicalDoctors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
