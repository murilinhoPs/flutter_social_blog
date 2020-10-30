import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  SharedPreferences prefs;

  Future getItem(String keyName) async {
    prefs = await SharedPreferences.getInstance();

    var key = prefs.get(keyName);

    return key;
  }

  void setItemString(String keyName, String keyValue) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setString(keyName, keyValue);
  }

  void setItemInt(String keyName, int keyValue) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt(keyName, keyValue);
  }

  Future<bool> deleteItem(String keyName) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.remove(keyName);
  }
}
