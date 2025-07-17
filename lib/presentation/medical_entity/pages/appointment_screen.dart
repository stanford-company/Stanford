import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medapp/common/components/arrow_back_widget.dart';
import 'package:medapp/core/constants/app_colors.dart';
import 'package:medapp/presentation/medical_entity/bloc/appointment_cubit.dart';
import 'package:medapp/presentation/medical_entity/pages/success_appointment.dart';

import '../../../common/components/basic_app_button.dart';
import '../../../data/medical_entity/model/medical_doctor.dart';
import '../../../data/medical_entity/model/medical_entity.dart';
import '../bloc/appointment_state.dart';

class AppointmentScreen extends StatelessWidget {
  final MedicalEntityModel? medicalEntity;
  final MedicalModel? medicalModel;

  const AppointmentScreen({super.key, this.medicalModel, this.medicalEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 22),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppBar(
                leading: ArrowBackWidget(),
                title:   Text('book_appointment'.tr()),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ),
        body: BlocConsumer<AppointmentCubit, AppointmentState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SuccessAppointmentPage(),
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<AppointmentCubit>();
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Divider(
                        height: 2.h,
                        color: AppColors.light_grey_color,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              (medicalEntity?.images != null && medicalEntity!.images!.isNotEmpty)
                                  ? medicalEntity!.images![0]
                                  : (medicalModel?.imageUrl ?? ""),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.locale.languageCode == 'ar'
                                    ? medicalEntity?.nameAr ?? medicalModel?.medicalName ?? ''
                                    : medicalEntity?.name ?? medicalModel?.medicalName ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                context.locale.languageCode == 'ar'
                                    ? medicalEntity?.descriptionAr ?? medicalModel?.description ?? ''
                                    : medicalEntity?.description ?? medicalModel?.description ?? '',
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Divider(
                        height: 2.h,
                        color: AppColors.light_grey_color,
                        thickness: 2,
                        radius: BorderRadius.circular(32.w),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0.h,
                        horizontal: 22.w,
                      ),
                      child: Text(
                        'visiting_date'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.0.h,
                        horizontal: 22.w,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: state.params.date ?? DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors.primary_color,
                                          onPrimary: Colors.white,
                                          onSurface: AppColors.primary_button_color,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.green,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (picked != null) cubit.setDate(picked);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xff98a2b3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/calendar.svg',
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      state.params.date != null
                                          ? '${state.params.date!.year}-${state.params.date!.month}-${state.params.date!.day}'
                                          : 'select_the_date'.tr(),
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: AppColors.primary_color,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors.primary_color,
                                          onPrimary: Colors.white,
                                          onSurface: AppColors.primary_button_color,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.green,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (picked != null) {
                                  final now = DateTime.now();
                                  final dateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                  cubit.setTime(dateTime);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xff98a2b3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/watch.svg',
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      state.params.time != null
                                          ? '${state.params.time!.hour.toString().padLeft(2, '0')}:${state.params.time!.minute.toString().padLeft(2, '0')}'
                                          : 'select_the_time'.tr(),
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: AppColors.primary_color,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0.h,
                        horizontal: 16.w,
                      ),
                      child: Divider(
                        height: 2.h,
                        color: AppColors.light_grey_color,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.0.h,
                        horizontal: 22.w,
                      ),
                      child: Text(
                        'patient_information'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0.h,
                        horizontal: 22.w,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'full_name'.tr(),
                          labelStyle: TextStyle(color: AppColors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF135242), width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'phone_number'.tr(),
                          labelStyle: TextStyle(color: AppColors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF135242), width: 2),
                          ),
                        ),
                        onChanged: (value) => cubit.setPhone(value),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(height: 12.w),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0.h,
                        horizontal: 22.w,
                      ),
                      child: TextFormField(
                        onChanged: (value) => cubit.setDetails(value),
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'case_details'.tr(),
                          labelStyle: TextStyle(color: AppColors.grey),
                          alignLabelWithHint: true,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF135242), width: 2),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.only(top: 136.w, right: 22.w, left: 22.w),
                      child: BasicAppButton(
                        text: "confirm_appointment".tr(),
                        isEnabled: cubit.isFormValid(),
                        onTap: cubit.isFormValid()
                            ? () {
                          final id = medicalEntity?.id ?? medicalModel?.id;
                          if (id != null) {
                            cubit.setAppointment(id);
                          } else {
                            print('object');

                          }
                        }
                            : null,
                      ),
                    ),
                      SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
