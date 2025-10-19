import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExitConfirmationWrapper extends StatelessWidget {
  final Widget child;

  const ExitConfirmationWrapper({super.key, required this.child});

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    print("Exit confirmation dialog called"); // Debug print

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'exit_app'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C3C4C),
              fontSize: 18.sp,
            ),
          ),
          content: Text(
            'are_you_sure_you_want_to_exit'.tr(),
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                print("Cancel pressed");
                Navigator.of(context).pop(false);
              },
              child: Text(
                'cancel'.tr(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                print("Exit pressed");
                Navigator.of(context).pop(true);
              },
              child: Text(
                'exit'.tr(),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    print("Dialog result: $result"); // Debug print

    if (result == true) {
      print("Closing app"); // Debug print
      SystemNavigator.pop();
    }

    // Always return false to prevent the default back action
    // The app closing is handled by SystemNavigator.pop() above
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitConfirmationDialog(context),
      child: child,
    );
  }
}
