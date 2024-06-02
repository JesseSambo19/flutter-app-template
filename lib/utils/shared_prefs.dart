// utils/shared_prefs.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  //! A utility class for interacting with SharedPreferences on the device.

  static Future<SharedPreferences> _getInstance() async {
    //! Retrieves an instance of SharedPreferences asynchronously.
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getString(String key) async {
    //! Retrieves a string value from SharedPreferences for the given key.
    final prefs = await _getInstance();
    return prefs.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    //! Sets a string value in SharedPreferences with the provided key and value.
    final prefs = await _getInstance();
    await prefs.setString(key, value);
  }

  static Future<bool?> getBool(String key) async {
    //! Retrieves a boolean value from SharedPreferences for the given key.
    final prefs = await _getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setBool(String key, bool value) async {
    //! Sets a boolean value in SharedPreferences with the provided key and value.
    final prefs = await _getInstance();
    await prefs.setBool(key, value);
  }

  static Future<int?> getInt(String key) async {
    //! Retrieves an integer value from SharedPreferences for the given key.
    final prefs = await _getInstance();
    return prefs.getInt(key);
  }

  static Future<void> setInt(String key, int value) async {
    //! Sets an integer value in SharedPreferences with the provided key and value.
    final prefs = await _getInstance();
    await prefs.setInt(key, value);
  }

  static Future<void> clear() async {
    //! Clears all stored preferences from the device.
    final prefs = await _getInstance();
    await prefs.clear();
  }

    static Future<void> remove(String key) async {
    //! Removes a value from SharedPreferences for the given key.
    final prefs = await _getInstance();
    await prefs.remove(key);
  }
}