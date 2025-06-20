import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SectionHeaderWidget({Key? key, required this.title, this.onPressed})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: Color(0xff113f4e),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          onPressed != null
              ? TextButton(
                  onPressed: onPressed,
                  child: Text(
                    'see_all'.tr(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 12.sp,
                      color: Color(0xff1b8064),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
