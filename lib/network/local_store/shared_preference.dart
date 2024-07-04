import 'package:shared_preferences/shared_preferences.dart';
import '../../core_utils/strings.dart';


class PreferenceUtils {
  static String? userImage;
  static String? userToken;
  var time = DateTime;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String? getString(String key, [String? defValue]) {
    if (PreferenceUtils._prefsInstance != null) {
      return _prefsInstance?.getString(key) ?? defValue ?? "";
    }
    return null;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value); //?? Future.value(null);
  }

  static Future<bool> setStringList(String key, var value) async {
    var prefs = await _instance;
    return prefs.setStringList(key, value); //?? Future.value(null);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value); //?? Future.value(null);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static List getStringList(String key, [bool? defValue]) {
    return _prefsInstance?.getStringList(key) ?? [defValue];
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value); //?? Future.value(null);
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }



  static String? getAccessToken() {
    return PreferenceUtils.getString(Strings.accessToken) ?? "";
  }



  static clearPreferences() {
    _prefsInstance?.clear();
  }


  static Future setAccessToken(String accessToken) async {
    await PreferenceUtils.setString(Strings.accessToken, accessToken);
  }


}
