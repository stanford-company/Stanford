import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/presentation/home/bloc/center_cubit.dart';

import '../../../common/components/medical_center_list_item.dart';
import '../../../core/routes/routes.dart';
import '../../main_home/widgets/section_header_widget.dart';

class MedicalCenterWidget extends StatelessWidget {
  const MedicalCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CenterCubit, CenterState>(
      builder: (context, state) {
        if (state is CenterLoading)
          return Center(child: CircularProgressIndicator());
        if (state is CenterFailure)
          return Center(child: Text('Something went wrong'));
        if (state is CenterLoaded)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: SectionHeaderWidget(
                  title: 'medical_centers'.tr(),
                  onPressed: () => Navigator.of(context).pushNamed(
                    Routes.allMedical,
                    arguments: state.medicalCenters,
                  ),
                ),
              ),
              Container(
                height: 160,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  itemCount: state.medicalCenters.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return MedicalCentersListItem(
                      medicalCenter: state.medicalCenters[index],
                    );
                  },
                ),
              ),
            ],
          );
        return SizedBox();
      },
    );
  }
}
