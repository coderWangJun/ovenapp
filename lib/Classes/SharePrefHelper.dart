import 'package:shared_preferences/shared_preferences.dart';

class SharePrefHelper {
/*
   * 存储数据
   */
  static SharedPreferences appPrefs;
  static initSP() async {
    if(appPrefs!=null) return;
    appPrefs = await SharedPreferences.getInstance();
    print("@@@ SharePrefHelper.initSP ...");
  }

  static Future saveData(String key, dynamic value) async {
    if(appPrefs==null) await initSP();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    appPrefs.setString(key, value);
    // print("@@@ SharePrefHelper.saveData($key : $value)");
  }

  /*
   * 读取数据
   */
  static Future<String> getData(String key) async {
    if(appPrefs==null) await initSP();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!appPrefs.containsKey(key)) return "";

    var value = appPrefs.get(key);
    if (value == null) {
      print("@@@ SharePrefHelper.getData (key:$key) => value : $value");
      return "";
    }
    return value;
  }

  /*
   * 删除数据
   */
  static Future removeData(String key) async {
    if(appPrefs==null) await initSP();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (appPrefs.containsKey(key)) appPrefs.remove(key);
    print("@@@ SharePrefHelper.removeData(key:$key)");
  }

    /*
   * 清空数据
   */
  static Future clearData() async {
    if(appPrefs==null) await initSP();
    bool blret = await appPrefs.clear();
    print("@@@ SharePrefHelper.clearData() ret : $blret");
  }
}
