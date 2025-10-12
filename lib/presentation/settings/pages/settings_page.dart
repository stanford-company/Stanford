import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
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
