import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_constants.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(AppConstants.loginPref);
  }

  Future<void> clearAllData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<void> setString(key,value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  Future<void> setBool(key,value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  Future<void> setInt(key,value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

//get value from shared preferences
  Future<String> getString(key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken;
    authToken = pref.getString(key)??"";
    return authToken;
  }
  Future<bool> getBool(key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool authToken;
    authToken = pref.getBool(key)??false;
    return authToken;
  }
  Future<int> getInt(key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int authToken;
    authToken = pref.getInt(key)??0;
    return authToken;
  }
}
