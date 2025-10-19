import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/pref_manager.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;

  const LanguageSwitcherWidget({
    super.key,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.activeTextColor,
    this.inactiveTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';

    return Container(
      height: 40.h,
      width: 140.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.5.w),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Prefs.setString(Prefs.LANGUAGE, 'en');
                  EasyLocalization.of(context)!.setLocale(
                    EasyLocalization.of(context)!.supportedLocales[0],
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isEnglish
                        ? (activeColor ?? Colors.white)
                        : (inactiveColor ?? Colors.transparent),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'English',
                    style: TextStyle(
                      color: isEnglish
                          ? (activeTextColor ?? Colors.black)
                          : (inactiveTextColor ?? Colors.white),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Prefs.setString(Prefs.LANGUAGE, 'ar');
                  EasyLocalization.of(context)!.setLocale(
                    EasyLocalization.of(context)!.supportedLocales[4],
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: !isEnglish
                        ? (activeColor ?? Colors.white)
                        : (inactiveColor ?? Colors.transparent),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'العربية',
                    style: TextStyle(
                      color: !isEnglish
                          ? (activeTextColor ?? Colors.black)
                          : (inactiveTextColor ?? Colors.white),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
