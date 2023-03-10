import 'package:flutter/cupertino.dart';
import 'package:learncoding/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification.dart';

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

class NotificationPreferences {
  static Future<bool> setNotif(String date, String message, bool read) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("date", date);
    prefs.setString("message", message);
    prefs.setBool("read", read);
    return true;
  }
}
