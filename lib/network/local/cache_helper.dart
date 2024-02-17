import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<dynamic> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences?.setString(key, value);
    if (value is int) return await sharedPreferences?.setInt(key, value);
    if (value is bool) return await sharedPreferences?.setBool(key, value);
    if (value is Locale) {
      final localeData = <String, String>{
        'languageCode': value.languageCode,
        'countryCode': value.countryCode ?? '',
      };
      return await sharedPreferences?.setString(key, jsonEncode(localeData));
    }
    return await sharedPreferences?.setDouble(key, value);
  }


  static Future<bool> removeData({required String key}) async {
    if (key == 'lang') {
      // Special handling for removing the language preference
      await sharedPreferences?.remove(key);
      return true; // Indicate success
    } else {
      // For other keys, remove as usual
      return await sharedPreferences?.remove(key) ?? false;
    }
  }

}