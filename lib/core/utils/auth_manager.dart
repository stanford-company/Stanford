import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'shared_prefs_service.dart';
import '../constants/const.dart';
import '../routes/routes.dart';
import '../services/navigation_service.dart';

class AuthManager {
  static bool _sessionExpiredMessageShown = false;

  /// Handles logout when user session expires or receives 401
  static Future<void> handleSessionExpired() async {
    print('🔐 Handling session expiration');

    // Show message to user
    _showSessionExpiredMessage();

    // Clear all user data
    await _clearUserData();

    // Navigate to login page after a brief delay
    Future.delayed(Duration(milliseconds: 500), () {
      _navigateToLogin();
    });
  }

  /// Manually logout user (for logout button)
  static Future<void> logout() async {
    print('🚪 Manual logout initiated');

    // Clear all user data
    await _clearUserData();

    // Navigate to login page
    _navigateToLogin();
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    final token = SharedPrefsService.getData(key: TextConst.userToken);
    return token != null && token.toString().isNotEmpty;
  }

  /// Get current user token
  static String? getUserToken() {
    return SharedPrefsService.getData(key: TextConst.userToken);
  }

  static void _showSessionExpiredMessage() {
    // Check if message has already been shown within the last minute
    if (_sessionExpiredMessageShown) {
      return;
    }

    final context = NavigationService.context;
    if (context != null) {
      _sessionExpiredMessageShown = true;

      ScaffoldMessenger.of(
        NavigationService.navigatorKey.currentContext!,
      ).showSnackBar(
        SnackBar(
          content: Text('session_expired_message'.tr()),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1), // Show for 1 second
        ),
      );

      // Reset the flag after 1 minute to allow showing again
      Future.delayed(Duration(minutes: 1), () {
        _sessionExpiredMessageShown = false;
      });
    }
  }

  static Future<void> _clearUserData() async {
    // Clear user token
    await SharedPrefsService.removeData(key: TextConst.userToken);

    // Clear other user-related data
    await SharedPrefsService.removeData(key: TextConst.userId);
    await SharedPrefsService.removeData(key: TextConst.userRole);
    await SharedPrefsService.removeData(key: TextConst.userFName);
    await SharedPrefsService.removeData(key: TextConst.userLName);
    await SharedPrefsService.removeData(key: TextConst.userPhone);
    await SharedPrefsService.removeData(key: TextConst.userEmail);
    await SharedPrefsService.removeData(key: TextConst.userDate);
    await SharedPrefsService.removeData(key: TextConst.userCategory);
    await SharedPrefsService.removeData(key: TextConst.userProfileImage);
    await SharedPrefsService.removeData(key: TextConst.userProviderId);
    await SharedPrefsService.removeData(key: TextConst.isVerified);

    print('✅ User data cleared');
  }

  static void _navigateToLogin() {
    final navigatorKey = NavigationService.navigatorKey;
    if (navigatorKey.currentContext != null) {
      // Clear the entire navigation stack and navigate to login
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(Routes.login, (route) => false);

      print('✅ Navigated to login screen');
    }
  }
}
