import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // var cubit = context.read<AppointmentCubit>();
    return BlocProvider(
      create: (context) => AppointmentCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('معلومات المريض'),
          centerTitle: true,
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
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            medicalEntity?.images[0] ??
                                medicalModel?.imageUrl ??
                                "",
                          ), // Replace with your image
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${medicalEntity?.name ?? medicalModel?.medicalName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              medicalEntity?.description ??
                                  medicalModel?.description ??
                                  "",
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Visit date and time
                    Text(
                      'موعد الزيارة',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: state.params.date != null
                                    ? state.params.date
                                    : DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              print(picked.toString().split(' ')[0]);
                              if (picked != null) cubit.setDate(picked);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xff98a2b3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.calendar_month,
                                    color: Color(0xff98a2b3),
                                  ),
                                  SizedBox(width: 12),

                                  Text(
                                    state.params.date != null
                                        ? '${state.params.date!.year}-${state.params.date!.month}-${state.params.date!.day}'
                                        : 'حدد التاريخ',
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Color(0xff98a2b3),
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
                                horizontal: 8,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xff98a2b3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 4),
                                  Icon(Icons.watch, color: Color(0xff98a2b3)),
                                  SizedBox(width: 12),

                                  Text(
                                    state.params.time != null
                                        ? '${state.params.time!.hour.toString().padLeft(2, '0')}:${state.params.time!.minute.toString().padLeft(2, '0')}'
                                        : 'حدد الوقت',
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Color(0xff98a2b3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Patient information
                    const Text(
                      'معلومات المريض',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'الاسم كامل',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => cubit.setPhone(value),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      onChanged: (value) => cubit.setDetails(value),
                      decoration: const InputDecoration(
                        labelText: 'تفاصيل الحالة',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    cubit.isFormValid()
                        ? BasicAppButton(
                            text: "تأكيد الموعد",
                            onTap: () {
                              cubit.setAppointment(medicalEntity!.id);
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
    ;
  }
}
