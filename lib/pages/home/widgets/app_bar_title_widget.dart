import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/images/launcher_ic.png', height: 131, width: 130),
      ],
    );
  }
}
