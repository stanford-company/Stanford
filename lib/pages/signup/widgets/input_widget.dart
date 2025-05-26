// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medapp/common/components/labeled_text_form_field.dart'
//     show LabeledTextFormField;
// import '../../../blocks/signup/signup_bloc.dart';
//
// class SignupInputWidget extends StatefulWidget {
//   @override
//   _SignupInputWidgetState createState() => _SignupInputWidgetState();
// }
//
// class _SignupInputWidgetState extends State<SignupInputWidget> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SignupBloc, SignupState>(
//       listenWhen: (previous, current) {
//         // Only listen if both states have nationalId and they differ
//         if (previous is SignupProceed && current is SignupProceed) {
//           return previous.nationalId != current.nationalId;
//         }
//         return false;
//       },
//       listener: (context, state) {
//         if (state is SignupProceed) {
//           _controller.value = TextEditingValue(
//             text: state.nationalId,
//             selection: TextSelection.collapsed(offset: state.nationalId.length),
//           );
//         }
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           LabeledTextFormField(
//             title: 'National ID',
//             hintText: 'National ID',
//             controller: _controller,
//             onChanged: (value) {
//               // Dispatch CheckNationalId event when user changes input
//               context.read<SignupBloc>().add(CheckNationalId(value));
//             },
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Enter your national number to verify your account",
//               style: TextStyle(color: Color(0xff98a2b3)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
