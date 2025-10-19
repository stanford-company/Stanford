import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Generic save data method supporting multiple types
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    if (value is String) return await _prefs!.setString(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);

    throw Exception("Unsupported value type for key: $key");
  }

  // Generic get data method
  static dynamic getData({required String key}) {
    return _prefs?.get(key);
  }

  // Remove specific data by key
  static Future<bool> removeData({required String key}) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return await _prefs!.remove(key);
  }

  // Boolean specific methods
  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return await _prefs!.setBool(key, value);
  }

  // Legacy methods for backward compatibility
  static const _authTokenKey = 'auth_token';
  static const _onboardingCompletedKey = 'onboarding_completed';

  static Future<void> saveToken(String token) async {
    await saveData(key: _authTokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return getData(key: _authTokenKey);
  }

  static Future<void> deleteToken() async {
    await removeData(key: _authTokenKey);
  }

  static Future<void> setOnboardingCompleted(bool completed) async {
    await saveData(key: _onboardingCompletedKey, value: completed);
  }

  static Future<bool> isOnboardingCompleted() async {
    return getData(key: _onboardingCompletedKey) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, completed);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> clearAll() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    await _prefs!.clear();
  }
}
