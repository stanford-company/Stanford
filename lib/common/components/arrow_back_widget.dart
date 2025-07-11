import 'package:flutter/cupertino.dart';
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
        child: SvgPicture.asset(
          'assets/images/svg/arrow_back.svg',
          width: 45.w,
          height: 45.h,
          fit: BoxFit.contain,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
