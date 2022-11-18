import 'package:shared_preferences/shared_preferences.dart';

class AsyncStorage {
  static const _storageVersion = 'v1';

  static String _makeKey(String key) {
    return '$_storageVersion/$key';
  }

  static Future<void> saveStringList(String key, List<String> list) async {
    final storageKey = _makeKey(key);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(storageKey, list);
  }

  static Future<void> addToStringList(String key, String value) async {
    var stringList = await getStringList(key);

    if (stringList == null) {
      stringList = [value];
    } else {
      stringList.add(value);
    }

    await saveStringList(key, stringList);
  }

  static Future<List<String>?> getStringList(String key) async {
    final storageKey = _makeKey(key);

    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(storageKey);
  }

  static Future<void> setBool(String key, bool value) async {
    final storageKey = _makeKey(key);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(storageKey, value);
  }

  static Future<bool?> getBool(String key) async {
    final storageKey = _makeKey(key);

    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(storageKey);
  }
}
