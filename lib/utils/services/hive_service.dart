import 'package:hive/hive.dart';

class HiveService {
  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('myBox');
  }

  static Box get box => _box;

  static Future<void> setData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  static dynamic getData(String key) {
    return _box.get(key);
  }

  static Future<void> deleteData(String key) async {
    await _box.delete(key);
  }
}
