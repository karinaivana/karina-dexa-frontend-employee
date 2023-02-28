import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefForObject {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);

    if (value != null) {
      return json.decode(value);
    } else {
      return null;
    }
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
