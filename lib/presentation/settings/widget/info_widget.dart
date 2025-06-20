import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/auth/model/profile.dart';
import 'profile_info_tile.dart';

class InfoWidget extends StatelessWidget {
  final ProfileModel profile;

  const InfoWidget({super.key, required this.profile});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            'name_dot'.tr(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            profile.fullName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Divider(
          height: 0.5,
          color: Colors.grey[200],
          indent: 15,
          endIndent: 15,
        ),
        ProfileInfoTile(
          title: 'contact_number'.tr(),
          trailing: profile.phone,
          hint: 'Add phone number',
        ),
        ProfileInfoTile(
          title: 'email'.tr(),
          trailing: profile.email,
          hint: 'add_email'.tr(),
        ),
        ProfileInfoTile(
          title: 'gender'.tr(),
          trailing: profile.gender,
          hint: 'add_gender'.tr(),
        ),
        ProfileInfoTile(
          title: 'national ID'.tr(),
          trailing: profile.nationalId,
          hint: 'add_gender'.tr(),
        ),
        ProfileInfoTile(
          title: 'Company'.tr(),
          trailing: profile.company,
          hint: 'add_gender'.tr(),
        ),
      ],
    );
  }
}
