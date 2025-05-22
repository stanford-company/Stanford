import 'package:flutter/material.dart';
import '../../../components/labeled_text_form_field.dart';

class SignupInputWidget extends StatelessWidget {
  final _nationalIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Ensures left alignment
      children: [
        LabeledTextFormField(
          title: 'National ID',
          controller: _nationalIdController,
          hintText: 'National ID',
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Enter your national number to verify your account",
            style: TextStyle(
              color: Color(0xff98a2b3),
            ),
          ),
        ),
      ],
    );
  }
}
