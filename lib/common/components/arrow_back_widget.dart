import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        alignment: Alignment.center,
        child: Icon(Icons.arrow_back, size: 24.w, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
