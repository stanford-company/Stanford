import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/components/medical_authorities_list_item.dart';
import '../../../core/routes/routes.dart';
import '../../main_home/widgets/section_header_widget.dart';
import '../bloc/doctor_cubit.dart';

class MedicalDoctorWidget extends StatelessWidget {
  const MedicalDoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorLoading) return CircularProgressIndicator();

        if (state is DoctorLoaded) {
          if (state.medicalDoctors.isEmpty) {
            return SizedBox(); // Return an empty widget if no doctors
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: SectionHeaderWidget(
                  title: 'medical_authorities'.tr(),
                  onPressed: () => Navigator.of(context).pushNamed(
                    Routes.allMedical,
                    arguments: state.medicalDoctors,
                  ),
                ),
              ),
              Container(
                height: 160,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 15.w),
                  itemCount: state.medicalDoctors.length <= 4
                      ? state.medicalDoctors.length
                      : 4,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return MedicalAuthoritiesListItem(
                      doctor: state.medicalDoctors[index],
                    );
                  },
                ),
              ),
            ],
          );
        }

        return SizedBox();
      },
    );
  }
}
