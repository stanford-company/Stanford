import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/presentation/auth/bloc/check_id_cubit.dart';
import 'package:medapp/presentation/auth/bloc/register_cubit.dart';
import 'package:medapp/presentation/auth/pages/header_widget.dart';

import '../../../common/components/custom_button.dart';
import '../../../core/routes/routes.dart';
import '../bloc/forgot_password_cubit.dart';
import '../bloc/forgot_password_state.dart';
import '../bloc/register_state.dart';

class CheckIdPage extends StatefulWidget {
  final bool isForgetPassword;

  const CheckIdPage({super.key, required this.isForgetPassword});

  @override
  _CheckIdPageState createState() => _CheckIdPageState();
}

class _CheckIdPageState extends State<CheckIdPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool showFullForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c3c4c),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CheckIdCubit()),
          BlocProvider(create: (_) => RegisterCubit()),
          BlocProvider(create: (_) => ForgotPasswordCubit()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<RegisterCubit, RegisterState>(
              listener: (context, regState) {
                if (regState is RegisterSuccess) {
                  final user = regState.user.data;
                  final token = regState.user.apiToken;

                  print('Registration Success:');
                  print('ID: ${user.id}');
                  print('Full Name: ${user.fullName}');
                  print('Email: ${user.email}');
                  print('National ID: ${user.nationalId}');
                  print('Phone: ${user.phone}');
                  print('Gender: ${user.gender}');
                  print('Sign Up Status: ${user.signUpStatus}');
                  print('API Token: $token');
                  print('Active: ${user.isActive}');

                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
                } else if (regState is RegisterFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(regState.message)));
                }
              },
            ),
            BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password updated successfully")),
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
                } else if (state is ForgotPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            ),
          ],
          child: Column(
            children: [
              HeaderWidget(),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0C3C4C),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      showFullForm
                                          ? 'Complete your details to register'
                                          : 'Enter your National ID to continue',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                controller: _nationalIdController,
                                decoration: InputDecoration(
                                  labelText: 'National ID',
                                  border: OutlineInputBorder(),
                                ),
                                enabled: !showFullForm,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your national ID';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              BlocConsumer<CheckIdCubit, CheckIdState>(
                                listener: (context, checkIdState) {
                                  if (checkIdState is CheckIdFailure) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(checkIdState.message),
                                      ),
                                    );
                                  } else if (checkIdState is CheckIdLoaded) {
                                    final model = checkIdState.checkIdModel;

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Text(model.message),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );

                                    if (model.signUpStatus == 'yes' &&
                                        !widget.isForgetPassword) {
                                      Navigator.of(
                                        context,
                                      ).pushNamedAndRemoveUntil(
                                        Routes.login,
                                            (Route<dynamic> route) => false,
                                      );
                                    }
                                  }
                                },
                                builder: (context, checkIdState) {
                                  if (checkIdState is CheckIdLoaded)
                                    return Column(
                                      children: [
                                        if (checkIdState
                                            .checkIdModel
                                            .signUpStatus ==
                                            "no" &&
                                            !widget.isForgetPassword) ...[
                                          TextFormField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              if (!value.contains('@')) {
                                                return 'Please enter a valid email';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              if (value.length < 6) {
                                                return 'Password must be at least 6 characters';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                        if (checkIdState
                                            .checkIdModel
                                            .signUpStatus ==
                                            "yes" &&
                                            widget.isForgetPassword) ...[
                                          TextFormField(
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              if (value.length < 6) {
                                                return 'Password must be at least 6 characters';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            controller:
                                            _confirmPasswordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              labelText: 'Confirm Password',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              if (_passwordController.text !=
                                                  _confirmPasswordController
                                                      .text) {
                                                return 'confirm password not the same password';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                        SizedBox(height: 40),
                                      ],
                                    );
                                  return SizedBox();
                                },
                              ),
                              BlocBuilder<CheckIdCubit, CheckIdState>(
                                builder: (context, state) {
                                  if (state is CheckIdLoading)
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  if (state is CheckIdLoaded)
                                    return CustomButton(
                                      text: 'Submit',
                                      onPressed: () async {
                                        print('object');
                                        final nationalId = _nationalIdController
                                            .text
                                            .trim();

                                        if (_formKey.currentState!.validate()) {
                                          if (widget.isForgetPassword &&
                                              state.checkIdModel.signUpStatus ==
                                                  "yes") {
                                            print("is forget password");

                                            context
                                                .read<ForgotPasswordCubit>()
                                                .forgotPassword(
                                              nationalId: nationalId,
                                              password: _passwordController
                                                  .text
                                                  .trim(),
                                              confirmPassword:
                                              _confirmPasswordController
                                                  .text
                                                  .trim(),
                                            );
                                          }

                                          if (!widget.isForgetPassword &&
                                              state.checkIdModel.signUpStatus ==
                                                  "no") {
                                            context
                                                .read<RegisterCubit>()
                                                .register(
                                              nationalId: nationalId,
                                              email: _emailController.text
                                                  .trim(),
                                              password: _passwordController
                                                  .text
                                                  .trim(),
                                            );
                                          }
                                        }
                                      },
                                    );
                                  return CustomButton(
                                    text: 'Continue',
                                    onPressed: () async {
                                      final nationalId = _nationalIdController
                                          .text
                                          .trim();

                                      context.read<CheckIdCubit>().checkID(
                                        nationalId: nationalId,
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Wrap(
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        color: Color(0xffbcbcbc),
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Color(0xFF1b8064),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
