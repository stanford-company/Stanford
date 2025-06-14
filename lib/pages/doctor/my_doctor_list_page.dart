import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/presentation/home/bloc/doctor_cubit.dart';

import '../../common/components/my_doctor_list_item.dart';
import '../../../model/doctor.dart';

class MyDoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('my_doctor_list'.tr())),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoading) return CircularProgressIndicator();
          if (state is DoctorLoaded)
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemCount: state.medicalDoctors.length,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              itemBuilder: (context, index) {
                return MyDoctorListItem(doctor: state.medicalDoctors[index]);
              },
            );
          return SizedBox();
        },
      ),
    );
  }
}
