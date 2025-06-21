import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/helper/cach_helper/cach_helper.dart';
import '../../../core/constants/const.dart';
import '../../../core/routes/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../auth/bloc/logout_cubit.dart';

class GeneralWidget extends StatelessWidget {
  const GeneralWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.grey[50],
          padding: EdgeInsets.all(15),
          child: Text(
            'general'.tr(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'language'.tr(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () => Navigator.of(context).pushNamed(Routes.changeLanguage),
        ),
        ListTile(
          leading: Text(
            'logout'.tr(),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(Icons.exit_to_app, color: Colors.blue),
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state is LogoutLoaded) {
                      CacheHelper.removeData(key: TextConst.isLogin);
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
                    } else if (state is LogoutFailure) {
                      Navigator.of(context).pop(); // Close dialog
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return AlertDialog(
                      title: Text('logout'.tr()),
                      content: state is LogoutLoading
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16.h),
                                Text('logging_out'.tr()),
                              ],
                            )
                          : Text('logout_confirmation'.tr()),
                      actions: [
                        if (state is! LogoutLoading)
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('cancel'.tr()),
                          ),
                        TextButton(
                          onPressed: state is LogoutLoading
                              ? null
                              : () {
                                  context.read<LogoutCubit>().logout();
                                },
                          child: Text(
                            'logout'.tr(),
                            style: TextStyle(
                              color: state is LogoutLoading
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
