import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicAppButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isEnabled;

  const BasicAppButton({
    super.key,
    this.onTap,
    required this.text,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 360.w,
        height: 48.h,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? const LinearGradient(
            colors: [Color(0xFF29A07B), Color(0xFF1B8064)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : null,
          color: isEnabled ? null : const Color(0xFFBDBDBD),
          border: Border.all(
            color: isEnabled ? const Color(0xFF156752) : const Color(0xFF9E9E9E),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isEnabled
              ? [
            const BoxShadow(
              color: Color(0x80156752),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
            const BoxShadow(
              color: Color(0x66FFFFFF),
              offset: Offset(0, 2),
              blurRadius: 0,
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
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
    );
  }
}
