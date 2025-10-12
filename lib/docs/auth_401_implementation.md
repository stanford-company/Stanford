# 🔐 Automatic 401 Logout Implementation

## Overview

This implementation automatically handles 401 Unauthorized responses by:

1. **Intercepting** all HTTP requests using Dio interceptor
2. **Detecting** 401 status codes
3. **Clearing** user session data
4. **Navigating** to login screen
5. **Showing** user-friendly message

## 📁 Files Created/Modified

### Core Infrastructure

- `lib/core/interceptors/auth_interceptor.dart` - Dio interceptor that catches 401 responses
- `lib/core/services/navigation_service.dart` - Global navigation service for interceptor access
- `lib/core/utils/auth_manager.dart` - Centralized authentication management
- `lib/core/utils/setup_service.dart` - Modified to add auth interceptor to Dio
- `lib/main.dart` - Modified to include NavigationService navigatorKey

### Test Utilities

- `lib/common/utils/auth_test_helper.dart` - Helper for testing auth functionality

## 🚀 How It Works

### 1. **Automatic 401 Detection**

```dart
// In AuthInterceptor
@override
void onError(DioException err, ErrorInterceptorHandler handler) {
  if (err.response?.statusCode == 401) {
    AuthManager.handleSessionExpired();
  }
  handler.next(err);
}
```

### 2. **Session Management**

```dart
// AuthManager handles all session logic
static Future<void> handleSessionExpired() async {
  // Show message to user
  _showSessionExpiredMessage();

  // Clear all user data
  await _clearUserData();

  // Navigate to login
  _navigateToLogin();
}
```

### 3. **Data Clearing**

The system automatically clears:

- User token
- User ID and role
- Personal information (name, email, phone)
- Profile settings
- Verification status

### 4. **Navigation**

Uses global NavigationService to:

- Clear entire navigation stack
- Navigate to login screen
- Show session expired message

## 💻 Usage Examples

### Manual Logout (for logout buttons)

```dart
import 'package:your_app/core/utils/auth_manager.dart';

// In any widget
ElevatedButton(
  onPressed: () async {
    await AuthManager.logout();
  },
  child: Text('Logout'),
)
```

### Check Login Status

```dart
if (AuthManager.isLoggedIn()) {
  // User is logged in
  print('Token: ${AuthManager.getUserToken()}');
} else {
  // User needs to login
}
```

### Testing 401 Response

```dart
import 'package:your_app/common/utils/auth_test_helper.dart';

// Simulate a 401 response to test the interceptor
await AuthTestHelper.simulateUnauthorizedRequest();
```

## 🔧 Implementation Details

### Dio Setup

```dart
// In setup_service.dart
final dio = Dio();
dio.interceptors.add(AuthInterceptor());
getIt.registerSingleton<ApiService>(ApiService(dio));
```

### MaterialApp Configuration

```dart
// In main.dart
MaterialApp(
  navigatorKey: NavigationService.navigatorKey, // Required for interceptor navigation
  // ... other properties
)
```

## 🎯 Features

✅ **Automatic logout on 401 responses**
✅ **Complete session data clearing**
✅ **User-friendly notification**
✅ **Stack-safe navigation**
✅ **Manual logout support**
✅ **Login status checking**
✅ **Token retrieval**
✅ **Test utilities**

## 🧪 Testing

### Test the Implementation:

1. **Automatic 401**: Make an API call that returns 401
2. **Manual Logout**: Call `AuthManager.logout()`
3. **Session Check**: Use `AuthManager.isLoggedIn()`

### Expected Behavior:

1. User sees "Session expired" message
2. All user data is cleared from cache
3. User is navigated to login screen
4. Navigation stack is cleared

## 🚨 Important Notes

1. **NavigatorKey Required**: The main MaterialApp must use `NavigationService.navigatorKey`
2. **Cache Helper**: Ensure CacheHelper is properly initialized
3. **Route Names**: Make sure `Routes.login` is properly defined
4. **Error Handling**: The interceptor still passes errors to next handlers

## 🔄 Flow Diagram

```
API Request → 401 Response → AuthInterceptor → AuthManager
                                ↓
User sees message ← Clear cache ← Navigate to login
```

## 🎨 Customization

### Custom Message

```dart
// In auth_manager.dart
static void _showSessionExpiredMessage() {
  // Customize the message here
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Your custom message')),
  );
}
```

### Additional Data Clearing

```dart
// Add more keys to clear in _clearUserData()
await CacheHelper.removeData(key: 'your_custom_key');
```

This implementation provides a robust, automatic solution for handling authentication failures and ensures users are properly logged out when their session expires.
