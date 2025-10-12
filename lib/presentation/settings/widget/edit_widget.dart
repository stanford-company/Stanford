import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/components/text_form_field.dart';
import '../../../../core/utils/constants.dart';
import '../../../data/auth/model/profile.dart';

class EditWidget extends StatefulWidget {
  final ProfileModel profile;

  const EditWidget({super.key, required this.profile});
  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Full Name'.tr(), style: kInputTextStyle),
            CustomTextFormField(
              controller: TextEditingController(text: widget.profile.fullName),
              hintText: 'enter_full_name'.tr(),
              validator: (value) =>
                  value!.isEmpty ? 'please_enter_valid_full_name'.tr() : null,
            ),

            SizedBox(height: 15),
            Text('contact_number_dot'.tr(), style: kInputTextStyle),
            CustomTextFormField(
              keyboardType: TextInputType.phone,
              hintText: 'phone_number_example'.tr(),
            ),
            SizedBox(height: 15),
            Text('email_dot'.tr(), style: kInputTextStyle),
            CustomTextFormField(hintText: 'email_example'.tr(), enabled: false),
            SizedBox(height: 15),
            Text('gender_dot'.tr(), style: kInputTextStyle),

            Text('height_dot'.tr(), style: kInputTextStyle),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              hintText: 'in_cm'.tr(),
            ),
            SizedBox(height: 15),
            Text('weight_dot'.tr(), style: kInputTextStyle),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              hintText: 'in_kg'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
