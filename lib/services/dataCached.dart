import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class DataCacheService {
  // for keep log in
  static Future<bool> getIsUserLoggedIn() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final value = sharedPreferences.getBool(kKeepMeLoggedIn);
    if (value != null) {
      return value;
    } else {
      return false;
    }
  }

  static Future<void> keepUserLoggedIn(bool keepMeLoggedIn) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }

  static Future<void> deleteData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kKeepMeLoggedIn);
    await preferences.remove(kIsAdmin);
  }

  // for save admin mode
  static Future<bool> getIsUserAdmin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final value = sharedPreferences.getBool(kIsAdmin);
    if (value != null) {
      return value;
    } else {
      return false;
    }
  }

  static Future<void> keepUserInAdminMode(bool saveMode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(kIsAdmin, saveMode);
  }
}
