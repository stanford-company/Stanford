import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Utility class to handle RTL-aware arrow icons throughout the app
class RTLArrowIcons {
  /// Returns appropriate back arrow icon based on current locale
  static IconData getBackArrow(BuildContext context) {
    return _isRTL(context) ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
  }

  /// Returns appropriate forward arrow icon based on current locale
  static IconData getForwardArrow(BuildContext context) {
    return _isRTL(context) ? Icons.arrow_back_ios : Icons.arrow_forward_ios;
  }

  /// Returns appropriate next arrow icon based on current locale
  static IconData getNextArrow(BuildContext context) {
    return _isRTL(context)
        ? Icons.keyboard_arrow_left
        : Icons.keyboard_arrow_right;
  }

  /// Returns appropriate previous arrow icon based on current locale
  static IconData getPreviousArrow(BuildContext context) {
    return _isRTL(context)
        ? Icons.keyboard_arrow_right
        : Icons.keyboard_arrow_left;
  }

  /// Returns appropriate chevron right icon based on current locale
  static IconData getChevronRight(BuildContext context) {
    return _isRTL(context) ? Icons.chevron_left : Icons.chevron_right;
  }

  /// Returns appropriate chevron left icon based on current locale
  static IconData getChevronLeft(BuildContext context) {
    return _isRTL(context) ? Icons.chevron_right : Icons.chevron_left;
  }

  /// Returns appropriate arrow drop down icon (same for both directions)
  static IconData getDropDownArrow() {
    return Icons.keyboard_arrow_down;
  }

  /// Returns appropriate arrow drop up icon (same for both directions)
  static IconData getDropUpArrow() {
    return Icons.keyboard_arrow_up;
  }

  /// Returns alignment based on current locale
  static Alignment getStartAlignment(BuildContext context) {
    return _isRTL(context) ? Alignment.centerRight : Alignment.centerLeft;
  }

  /// Returns alignment based on current locale
  static Alignment getEndAlignment(BuildContext context) {
    return _isRTL(context) ? Alignment.centerLeft : Alignment.centerRight;
  }

  /// Returns cross axis alignment for RTL support
  static CrossAxisAlignment getStartCrossAxisAlignment(BuildContext context) {
    return _isRTL(context) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  }

  /// Returns cross axis alignment for RTL support
  static CrossAxisAlignment getEndCrossAxisAlignment(BuildContext context) {
    return _isRTL(context) ? CrossAxisAlignment.start : CrossAxisAlignment.end;
  }

  /// Returns main axis alignment for RTL support
  static MainAxisAlignment getStartMainAxisAlignment(BuildContext context) {
    return _isRTL(context) ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  /// Returns main axis alignment for RTL support
  static MainAxisAlignment getEndMainAxisAlignment(BuildContext context) {
    return _isRTL(context) ? MainAxisAlignment.start : MainAxisAlignment.end;
  }

  /// Returns appropriate edge insets for RTL support
  static EdgeInsets getStartPadding(BuildContext context, double value) {
    return _isRTL(context)
        ? EdgeInsets.only(right: value)
        : EdgeInsets.only(left: value);
  }

  /// Returns appropriate edge insets for RTL support
  static EdgeInsets getEndPadding(BuildContext context, double value) {
    return _isRTL(context)
        ? EdgeInsets.only(left: value)
        : EdgeInsets.only(right: value);
  }

  /// Check if current locale is RTL using Easy Localization context
  static bool _isRTL(BuildContext context) {
    return context.locale.languageCode == 'ar';
  }

  /// Returns appropriate floating action button location
  static FloatingActionButtonLocation getFABLocation(BuildContext context) {
    return _isRTL(context)
        ? FloatingActionButtonLocation.startFloat
        : FloatingActionButtonLocation.endFloat;
  }
}

/// Extension on BuildContext for easy RTL support
extension RTLExtension on BuildContext {
  bool get isRTL => locale.languageCode == 'ar';

  IconData get backArrow => RTLArrowIcons.getBackArrow(this);
  IconData get forwardArrow => RTLArrowIcons.getForwardArrow(this);
  IconData get nextArrow => RTLArrowIcons.getNextArrow(this);
  IconData get previousArrow => RTLArrowIcons.getPreviousArrow(this);

  Alignment get startAlignment => RTLArrowIcons.getStartAlignment(this);
  Alignment get endAlignment => RTLArrowIcons.getEndAlignment(this);
}
