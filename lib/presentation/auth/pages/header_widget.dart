import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';

    return   Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xFF0C3C4C)),
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
                        onTap: () => context.setLocale(Locale('en')),
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
                        onTap: () => context.setLocale(Locale('ar')),
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
    );
  }
}
