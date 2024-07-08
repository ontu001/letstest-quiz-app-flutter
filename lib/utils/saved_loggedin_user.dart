import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUserInfo {
  static const String userLoggedInKey = "USERLOGGEDINKEY";

  static saveLoggedInUser({@required bool? loggedIn}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (loggedIn != null) {
      sharedPreferences.setBool(userLoggedInKey, loggedIn);
    }
  }

  static Future<bool?> getUserLoggedInDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   return sharedPreferences.getBool(userLoggedInKey);
  }
}
