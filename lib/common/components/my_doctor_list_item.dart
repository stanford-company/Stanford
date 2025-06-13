import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medapp/data/medical_entity/model/medical_doctor.dart';

import '../../model/doctor.dart';
import 'custom_button.dart';

class MyDoctorListItem extends StatelessWidget {
  final MedicalModel doctor;

  const MyDoctorListItem({Key? key, required this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: <Widget>[
            Image.network(doctor.imageUrl, width: 60, height: 60),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    doctor.medicalName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    doctor.categoryEn + '\n',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            CustomButton(
              text: 'details'.tr(),
              textSize: 14,
              onPressed: () {},
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            ),
          ],
        ),
      ),
    );
  }
}
