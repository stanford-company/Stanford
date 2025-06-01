import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double elevation;
  final double borderRadius;
  final EdgeInsets? padding;
  final double? textSize;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.elevation = 0,
    this.borderRadius = 4,
    this.padding,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        RawMaterialButton(
          onPressed: onPressed,
          elevation: elevation,
          fillColor: Color(0xff228f6f),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.only(top: 9, bottom: 10, left: 16, right: 16),
            child: Stack(
              children:[ Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize:
                          textSize ??
                          Theme.of(context).textTheme.labelLarge!.fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),]
            ),
          ),
        ),

      ],
    );
  }
}
