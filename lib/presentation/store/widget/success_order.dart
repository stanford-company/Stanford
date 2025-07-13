import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/common/components/basic_app_button.dart';
import 'package:medapp/core/constants/app_colors.dart';

class SuccessOrderPage extends StatelessWidget {
  const SuccessOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/success_appointment.png"),
            SizedBox(height: 25),
            Text(
              "Order Submitted Successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28.sp,
                color: AppColors.primary_color,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Our team will contact you soon to confirm the order and arrange delivery.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 10),
            BasicAppButton(
              text: "Go to Home",
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),

      ),
    );
  }
}
