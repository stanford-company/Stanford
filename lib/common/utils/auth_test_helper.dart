import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/utils/auth_manager.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/setup_service.dart';

class AuthTestHelper {
  /// Test method to simulate receiving a 401 response
  static Future<void> simulateUnauthorizedRequest() async {
    try {
      // This will trigger our interceptor
      final apiService = getIt<ApiService>();

      // Create a fake request that will return 401
      print('🧪 Simulating 401 Unauthorized request...');

      await apiService.get(endPoint: 'test-unauthorized-endpoint');
    } catch (e) {
      print('Expected error caught: $e');
    }
  }

  /// Method to manually trigger logout (for logout button)
  static Future<void> manualLogout() async {
    print('🚪 Manual logout triggered from UI');
    await AuthManager.logout();
  }

  /// Check if user is currently logged in
  static bool isUserLoggedIn() {
    return AuthManager.isLoggedIn();
  }
}

// Widget to test the auth functionality
class AuthTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('auth_test'.tr())),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Authentication Test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Text(
              'User Status: ${AuthTestHelper.isUserLoggedIn() ? "Logged In" : "Not Logged In"}',
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                AuthTestHelper.simulateUnauthorizedRequest();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('simulate_401_response'.tr()),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                AuthTestHelper.manualLogout();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('manual_logout'.tr()),
            ),

            SizedBox(height: 20),

            Text(
              'Instructions:\n'
              '• "Simulate 401 Response": This will trigger the auth interceptor\n'
              '• "Manual Logout": This will manually log out the user\n'
              '• Both should navigate to login screen and clear user data',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
