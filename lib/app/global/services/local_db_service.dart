import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  SharedPreferences prefs;

  Future getItem(String keyName) async {
    prefs = await SharedPreferences.getInstance();

    var key = prefs.get(keyName);

    return key;
  }

  Future setItemString(String keyName, String keyValue) async {
    prefs = await SharedPreferences.getInstance();

    return await prefs.setString(keyName, keyValue);
  }

  Future setItemInt(String keyName, int keyValue) async {
    prefs = await SharedPreferences.getInstance();

    return await prefs.setInt(keyName, keyValue);
  }

  Future<bool> deleteItem(String keyName) async {
    prefs = await SharedPreferences.getInstance();

    return await prefs.remove(keyName);
  }

  Future<bool> deleteAll() async {
    prefs = await SharedPreferences.getInstance();

    return await prefs.clear();
  }
}
