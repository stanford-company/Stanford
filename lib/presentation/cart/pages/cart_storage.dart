import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorage {
  static const _cartKey = 'cart_items';

  static Future<void> saveCartItems(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items);
    await prefs.setString(_cartKey, encoded);
  }

  static Future<List<Map<String, dynamic>>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_cartKey);
    if (encoded == null) return [];
    final decoded = jsonDecode(encoded) as List;
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
