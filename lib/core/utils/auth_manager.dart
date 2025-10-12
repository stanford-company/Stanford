import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../common/helper/cach_helper/cach_helper.dart';
import '../constants/const.dart';
import '../routes/routes.dart';
import '../services/navigation_service.dart';

class AuthManager {
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
    final token = CacheHelper.getData(key: TextConst.userToken);
    return token != null && token.toString().isNotEmpty;
  }

  /// Get current user token
  static String? getUserToken() {
    return CacheHelper.getData(key: TextConst.userToken);
  }

  static void _showSessionExpiredMessage() {
    final context = NavigationService.context;
    if (context != null) {
      ScaffoldMessenger.of(
        NavigationService.navigatorKey.currentContext!,
      ).showSnackBar(
        SnackBar(
          content: Text('session_expired_message'.tr()),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  static Future<void> _clearUserData() async {
    // Clear user token
    await CacheHelper.removeData(key: TextConst.userToken);

    // Clear other user-related data
    await CacheHelper.removeData(key: TextConst.userId);
    await CacheHelper.removeData(key: TextConst.userRole);
    await CacheHelper.removeData(key: TextConst.userFName);
    await CacheHelper.removeData(key: TextConst.userLName);
    await CacheHelper.removeData(key: TextConst.userPhone);
    await CacheHelper.removeData(key: TextConst.userEmail);
    await CacheHelper.removeData(key: TextConst.userDate);
    await CacheHelper.removeData(key: TextConst.userCategory);
    await CacheHelper.removeData(key: TextConst.userProfileImage);
    await CacheHelper.removeData(key: TextConst.userProviderId);
    await CacheHelper.removeData(key: TextConst.isVerified);

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
