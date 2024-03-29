import 'package:flutter/cupertino.dart';
import 'package:learncoding/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
// set AuthToken once user login completed
  static Future<bool> setuser(String image, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("image", image);
    prefs.setString("name", name);

    return true;
  }

  static Future<User> getuser(String image, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("name");
    // Image? image = prefs.getString("image");
    return User(name: name, image: image);
  }
}
