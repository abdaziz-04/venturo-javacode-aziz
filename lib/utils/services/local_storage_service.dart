import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final box = Hive.box("venturo");

  static Future deleteAuth() async {
    if (box.get("IsRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }
}
