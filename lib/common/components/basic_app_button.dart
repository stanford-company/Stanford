import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicAppButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const BasicAppButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 360.w,
        height: 48.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF29A07B), Color(0xFF1B8064)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: Color(0xFF156752), width: 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // outer shadow
              color: Color(0x80156752), // #15675280
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              // inner inset shadow
              color: Color(0x66FFFFFF), // #FFFFFF40
              offset: Offset(0, 2),
              blurRadius: 0,
              spreadRadius: 1,
              // requires flutter_inset_box_shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          child: Center(
            child: Text(
              text.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
