import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/round_icon_button.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/constants.dart';
import '../bloc/profile_cubit.dart';

class SettingsWidget extends StatefulWidget {
  final Color color;

  const SettingsWidget({Key? key, required this.color}) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: widget.color,
          padding: EdgeInsets.all(15),
          child: Text(
            'accounts'.tr(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoadedState) {
              return Container(
                padding: EdgeInsets.all(20),
                //color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.profile.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 3),
                          Text(
                            state.profile.email,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            state.profile.phone,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
