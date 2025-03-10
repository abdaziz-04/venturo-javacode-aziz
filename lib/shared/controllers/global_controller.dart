import 'dart:io';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../constants/cores/api/api_constant.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();
  var isConnect = false.obs;
  var baseUrl = ApiConstant.production;
  var isStaging = false.obs;
  static const String boxName = 'auth';
  static const String loginKey = 'isLoggedIn';
  static const String tokenKey = 'authToken';

  static Future<void> setToken(String token) async {
    var box = await Hive.openBox(boxName);
    await box.put(tokenKey, token);
  }

  static Future<String?> getsToken() async {
    var box = await Hive.openBox(boxName);
    return box.get(tokenKey) as String?;
  }

  static Future<void> clearToken() async {
    var box = await Hive.openBox(boxName);
    await box.delete(tokenKey);
  }

  static Future<void> setLoggedIn(bool value) async {
    var box = await Hive.openBox(boxName);
    await box.put(loginKey, value);
  }

  static Future<bool> isLoggedIn() async {
    var box = await Hive.openBox(boxName);
    return box.get(loginKey, defaultValue: false) as bool;
  }

  static Future<void> clearLogin() async {
    var box = await Hive.openBox(boxName);
    await box.delete(loginKey);
  }

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnect.value = true;
      }
    } on SocketException catch (exception, stackTrace) {
      isConnect.value = false;
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
