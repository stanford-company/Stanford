import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocks/login/login_bloc.dart';
import '../../../blocks/remember_me_bloc.dart';
import '../../../common/components/custom_button.dart';
import '../../../common/components/labeled_text_form_field.dart';
import '../../../core/routes/routes.dart';

class LoginInputWidget extends StatefulWidget {
  @override
  _LoginInputWidgetState createState() => _LoginInputWidgetState();
}

class _LoginInputWidgetState extends State<LoginInputWidget> {
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LabeledTextFormField(
            title: 'National ID'.tr(),
            controller: _nationalIdController,
            keyboardType: TextInputType.number,
            hintText: 'National ID',

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
            title: 'Password'.tr(),
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
                          value: state.isChecked,
                          onChanged: (value) {
                            context.read<RememberMeBloc>().add(
                              ToggleRememberMe(value ?? false),
                            );
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      Text(
                        'Remember me'.tr(),
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
                  Navigator.of(context).pushNamed(Routes.forgotPassword);
                },
                child: Text(
                  'Forgot password?'.tr(),
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
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return CustomButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                    LoginSubmitted(
                      nationalId: _nationalIdController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                  );
                },
                text: 'Login'.tr(),
              );
            },
          ),
        ],
      ),
    );
  }
}
