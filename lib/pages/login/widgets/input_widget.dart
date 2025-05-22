import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocks/remember_me_bloc.dart';
import '../../../components/labeled_text_form_field.dart';
import '../../../routes/routes.dart';

class InputWidget extends StatefulWidget {
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true; // For toggling password visibility

  @override
  Widget build(BuildContext context) {
    return Column(
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
              padding:   EdgeInsets.all(12.0.w),
              child: SvgPicture.asset(
                'assets/images/svg/person.svg',
                height: 20.h,
                width: 20.w,
                color: Color(0xff113f4e),
              ),
            ),
          ),
        ),
        LabeledTextFormField(
          title: 'password_dot'.tr(),
          controller: _passwordController,
          obscureText: _obscurePassword,
          hintText: '* * * * * *',
          padding: 0,
          prefixIcon: SizedBox(
            width: 48.w,
            height: 48.h,
            child: Padding(
              padding:   EdgeInsets.all(12.0.w),
              child: SvgPicture.asset(
                'assets/images/svg/key-square(1).svg',
                height: 20,
                width: 20,
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
            // Remember me checkbox
            BlocBuilder<RememberMeBloc, RememberMeState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        checkboxTheme: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(
                            color: Color(0xFF80d5b5),
                            width: 2,
                          )),
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Color(0x6680D5B5);
                            }
                            return Colors.transparent;
                          }),
                          checkColor: MaterialStateProperty.all<Color>(Color(0xFF156752)),
                        ),
                      ),
                      child: Checkbox(
                        value: state.isChecked,
                        onChanged: (value) {
                          context.read<RememberMeBloc>().add(ToggleRememberMe(value ?? false));
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            // Forgot password text button
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.forgotPassword);
              },
              child: Text(
                'forgot_yout_password'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(
                  fontSize: 12.sp,
                  color: const Color(0xFF1B8064),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
