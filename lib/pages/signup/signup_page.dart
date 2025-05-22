import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medapp/pages/signup/widgets/input_widget.dart';

import '../../components/custom_button.dart';
import '../../routes/routes.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';

    return Scaffold(
      backgroundColor: Color(0xff0c3c4c),
      body: Column(
        children: [
          // Fixed Header
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF0C3C4C),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0, right: 8, left: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      'assets/images/launcher_ic-white.png',
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.setLocale(Locale('en'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isEnglish ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                    color: isEnglish ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.setLocale(Locale('ar'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: !isEnglish ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'العربية',
                                  style: TextStyle(
                                    color: !isEnglish ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable content
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
                                'Enter your National ID to continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        SignupInputWidget(), // only National ID field
                        SizedBox(height: 40),
                        CustomButton(
                          onPressed: () {
                            // Add your create logic here
                            Navigator.of(context).popAndPushNamed(Routes.home);
                          },
                          text: 'Create Account',
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
                                onTap: () {
                                  Navigator.of(context).pushNamed(Routes.login);
                                },
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
        ],
      ),
    );
  }
}
