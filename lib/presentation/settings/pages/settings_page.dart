import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_themes.dart';
import '../../../data/pref_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../core/utils/themebloc/theme_bloc.dart';
import '../widget/widgets.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SettingsWidget(color: Colors.grey[50]!),
              GeneralWidget(),

              SizedBox(height: kBottomPadding),
            ],
          ),
        ),
      ),
    );
  }
}
