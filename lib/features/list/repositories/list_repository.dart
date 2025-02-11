import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/features/list/constants/list_api_constant.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ListRepository {
  final Dio _dio;

  final String apiMenu = ListApiConstant().apiMenu;
  final String apiDetailbyId = ListApiConstant().apiMenuDetail;
  final String apiMenuCategory = ListApiConstant().apiMenuCategory;

  ListRepository({Dio? dioInstance}) : _dio = dioInstance ?? Dio();

  Future<String?> _getToken() async {
    final box = await Hive.openBox('venturo');
    final token = box.get('token', defaultValue: '');
    if (token.isEmpty) {
      print("⚠️ Token kosong! Coba login ulang.");
      return null;
    }
    return token;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final token = await _getToken();
    if (token == null) return [];
    try {
      Response response = await _dio.get(
        apiMenu,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        if (result is Map &&
            result.containsKey('data') &&
            result['data'] is Iterable) {
          return List<Map<String, dynamic>>.from(result['data']);
        }
      } else if (response.statusCode == 204) {
        return [];
      }
    } catch (e) {
      print("🚨 Error saat fetch all data: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getDataByCategory(String category) async {
    final token = await _getToken();
    if (token == null) return [];
    final String url = apiMenuCategory + category;
    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        if (result is Map &&
            result.containsKey('data') &&
            result['data'] is Iterable) {
          return List<Map<String, dynamic>>.from(result['data']);
        }
      } else if (response.statusCode == 204) {
        return [];
      }
    } catch (e) {
      print("🚨 Error saat fetch data kategori: $e");
    }
    return [];
  }

  Future<Map<String, dynamic>?> getDataByDetail(int id) async {
    final token = await _getToken();
    if (token == null) return null;
    final String url = "$apiDetailbyId$id";
    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        if (result is Map && result.containsKey('data')) {
          return Map<String, dynamic>.from(result['data']);
        }
      } else if (response.statusCode == 204) {
        return null;
      }
    } catch (e) {
      print("🚨 Error saat fetch detail data: $e");
    }
    return null;
  }

  Future<bool> deleteItem(Map<String, dynamic> itemToDelete) async {
    final token = await _getToken();
    if (token == null) return false;
    try {
      Response response = await _dio.delete(
        "$apiMenu/${itemToDelete['id_menu']}",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (exception, stacktrace) {
      print("🚨 Error saat delete item: $exception");
      await Sentry.captureException(exception, stackTrace: stacktrace);
    }
    return false;
  }
}
