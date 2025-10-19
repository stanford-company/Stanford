import 'package:flutter/material.dart';
import 'package:medapp/core/utils/shared_prefs_service.dart';
import 'package:medapp/core/routes/routes.dart';

class OnboardingTestWidget extends StatelessWidget {
  const OnboardingTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await SharedPrefsService.setOnboardingCompleted(false);
                Navigator.of(context).pushReplacementNamed(Routes.onboarding);
              },
              child: const Text('Reset Onboarding'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final isCompleted =
                    await SharedPrefsService.isOnboardingCompleted();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Onboarding completed: $isCompleted')),
                );
              },
              child: const Text('Check Onboarding Status'),
            ),
          ],
        ),
      ),
    );
  }
}
