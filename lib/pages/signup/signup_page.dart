// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocks/signup/signup_bloc.dart';
//
// import '../../common/components/custom_button.dart';
// import '../../common/components/wave_header.dart';
// import '../../core/routes/routes.dart';
// import '../../core/utils/api_service.dart';
// import 'widgets/input_widget.dart';
//
// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nationalIdController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool showFullForm = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final isEnglish = context.locale.languageCode == 'en';
//
//     return Scaffold(
//       backgroundColor: Color(0xff0c3c4c),
//       body: BlocProvider(
//         create: (_) => SignupBloc(ApiService()),
//         child: BlocConsumer<SignupBloc, SignupState>(
//           listener: (context, state) {
//             if (state is SignupFailure) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.error)));
//             } else if (state is SignupSuccess) {
//               // Show success message and navigate
//               ScaffoldMessenger.of(context)
//                 ..hideCurrentSnackBar()
//                 ..showSnackBar(
//                   SnackBar(
//                     content: Text(state.message),
//                     duration: Duration(seconds: 2),
//                   ),
//                 ).closed.then((_) {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                     Routes.login,
//                     (Route<dynamic> route) => false,
//                   );
//                 });
//             } else if (state is SignupProceed) {
//               setState(() {
//                 showFullForm = true;
//                 _nationalIdController.text = state.nationalId;
//               });
//             }
//           },
//           builder: (context, state) {
//             return Column(
//               children: [
//                 // Header
//                 Container(
//                   height: 180,
//                   width: double.infinity,
//                   decoration: BoxDecoration(color: Color(0xFF0C3C4C)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 100.0,
//                       right: 8,
//                       left: 8,
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Image.asset(
//                             'assets/images/launcher_ic-white.png',
//                             height: 60,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           height: 40,
//                           width: 140,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.4),
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.5),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () =>
//                                         context.setLocale(Locale('en')),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: isEnglish
//                                             ? Colors.white
//                                             : Colors.transparent,
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'English',
//                                         style: TextStyle(
//                                           color: isEnglish
//                                               ? Colors.black
//                                               : Colors.white,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () =>
//                                         context.setLocale(Locale('ar')),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: !isEnglish
//                                             ? Colors.white
//                                             : Colors.transparent,
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         'العربية',
//                                         style: TextStyle(
//                                           color: !isEnglish
//                                               ? Colors.black
//                                               : Colors.white,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Content
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20.0),
//                       topRight: Radius.circular(20.0),
//                     ),
//                     child: Container(
//                       color: Colors.white,
//                       child: SingleChildScrollView(
//                         physics: ClampingScrollPhysics(),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 38),
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 SizedBox(height: 30),
//                                 Center(
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         'Create Account',
//                                         style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xFF0C3C4C),
//                                         ),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text(
//                                         showFullForm
//                                             ? 'Complete your details to register'
//                                             : 'Enter your National ID to continue',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 30),
//
//                                 // National ID Field
//                                 TextFormField(
//                                   controller: _nationalIdController,
//                                   decoration: InputDecoration(
//                                     labelText: 'National ID',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   enabled: !showFullForm,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter your national ID';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 20),
//
//                                 // Additional fields when proceeding
//                                 if (showFullForm) ...[
//                                   TextFormField(
//                                     controller: _emailController,
//                                     decoration: InputDecoration(
//                                       labelText: 'Email',
//                                       border: OutlineInputBorder(),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your email';
//                                       }
//                                       if (!value.contains('@')) {
//                                         return 'Please enter a valid email';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   SizedBox(height: 20),
//                                   TextFormField(
//                                     controller: _passwordController,
//                                     obscureText: true,
//                                     decoration: InputDecoration(
//                                       labelText: 'Password',
//                                       border: OutlineInputBorder(),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter a password';
//                                       }
//                                       if (value.length < 6) {
//                                         return 'Password must be at least 6 characters';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ],
//
//                                 SizedBox(height: 40),
//
//                                 // Submit Button
//                                 if (state is SignupLoading)
//                                   Center(child: CircularProgressIndicator())
//                                 else
//                                   CustomButton(
//                                     text: showFullForm ? 'Submit' : 'Continue',
//                                     onPressed: () {
//                                       if (_formKey.currentState!.validate()) {
//                                         final bloc =
//                                             BlocProvider.of<SignupBloc>(
//                                               context,
//                                             );
//                                         if (showFullForm) {
//                                           bloc.add(
//                                             SubmitFullSignup(
//                                               nationalId: _nationalIdController
//                                                   .text
//                                                   .trim(),
//                                               email: _emailController.text
//                                                   .trim(),
//                                               password: _passwordController.text
//                                                   .trim(),
//                                             ),
//                                           );
//                                         } else {
//                                           bloc.add(
//                                             CheckNationalId(
//                                               _nationalIdController.text.trim(),
//                                             ),
//                                           );
//                                         }
//                                       }
//                                     },
//                                   ),
//
//                                 SizedBox(height: 20),
//                                 Center(
//                                   child: Wrap(
//                                     children: [
//                                       Text(
//                                         'Already have an account? ',
//                                         style: TextStyle(
//                                           color: Color(0xffbcbcbc),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () =>
//                                             Navigator.of(context).pop(),
//                                         child: Text(
//                                           'Login',
//                                           style: TextStyle(
//                                             color: Color(0xFF1b8064),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 20),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
