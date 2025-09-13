import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medapp/core/utils/constants.dart';

import '../../../blocks/remember_me_bloc.dart';
import '../../../common/components/custom_button.dart';
import '../../../common/components/labeled_text_form_field.dart';
import '../../../common/helper/cach_helper/cach_helper.dart';
import '../../../core/constants/const.dart';
import '../../../core/routes/routes.dart';
import '../bloc/login_cubit.dart';

class LoginInputWidget extends StatefulWidget {
  @override
  _LoginInputWidgetState createState() => _LoginInputWidgetState();
}

class _LoginInputWidgetState extends State<LoginInputWidget> {
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    _loadSavedCredentials();
    super.initState();
  }

  void _loadSavedCredentials() async {
    final isRemembered = await CacheHelper.getData(key: 'remember_me') ?? false;
    if (isRemembered) {
      final savedNationalId =
          await CacheHelper.getData(key: 'national_id') ?? '';
      final savedPassword = await CacheHelper.getData(key: 'password') ?? '';
      setState(() {
        _nationalIdController.text = savedNationalId;
        _passwordController.text = savedPassword;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoaded) {
          if (state.userParams.data.signUpStatus == 'yes') {
            await CacheHelper.saveData(key: TextConst.isLogin, value: true);
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (Route<dynamic> route) => false,
            );
          } else {
            //show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr('should register_first'))),
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.signup,
              (Route<dynamic> route) => false,
            );
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginFailure && state.message.isNotEmpty) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5D5D),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          LabeledTextFormField(
            title: 'national_id'.tr(),
            controller: _nationalIdController,
            keyboardType: TextInputType.number,
            hintText: 'national_id'.tr(),
            prefixIcon: SizedBox(
              width: 48.w,
              height: 48.h,
              child: Padding(
                padding: EdgeInsets.all(12.0.w),
                child: SvgPicture.asset(
                  'assets/images/svg/person.svg',
                  height: 20.h,
                  width: 20.w,
                  color: Color(0xff113f4e),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          LabeledTextFormField(
            title: 'password'.tr(),
            controller: _passwordController,
            obscureText: _obscurePassword,
            hintText: '* * * * * *',
            prefixIcon: SizedBox(
              width: 48.w,
              height: 48.h,
              child: Padding(
                padding: EdgeInsets.all(12.0.w),
                child: SvgPicture.asset(
                  'assets/images/svg/key-square(1).svg',
                  height: 20.h,
                  width: 20.w,
                  color: Color(0xff113f4e),
                ),
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              BlocBuilder<RememberMeBloc, RememberMeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                color: Color(0xFF80d5b5),
                                width: 2,
                              ),
                            ),
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(0x6680D5B5);
                                }
                                return Colors.transparent;
                              },
                            ),
                            checkColor: MaterialStateProperty.all<Color>(
                              Color(0xFF156752),
                            ),
                          ),
                        ),
                        child: Checkbox(
                          value: CacheHelper.getData(key: 'remember_me'),
                          onChanged: (value) {
                            context.read<RememberMeBloc>().add(
                              ToggleRememberMe(value ?? false),
                            );

                            CacheHelper.saveData(
                              key: 'remember_me',
                              value: value ?? false,
                            );
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      Text(
                        'remember_me'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  );
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(Routes.signup, arguments: true);
                },
                child: Text(
                  'forgot_password'.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF1B8064),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return CustomButton(
                onPressed: () {
                  context.read<LoginCubit>().login(
                    nationalId: _nationalIdController.text.trim(),
                    password: _passwordController.text.trim(),
                    rememberMe: context.read<RememberMeBloc>().state.isChecked,
                  );
                },
                text: 'login'.tr(),
              );
            },
          ),
        ],
      ),
    );
  }
}
