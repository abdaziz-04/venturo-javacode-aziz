import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/features/list/constants/list_api_constant.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ListRepository {
  final List<Map<String, dynamic>> data = [];
  final String apiMenu = ListApiConstant().apiMenu;
  final String apiDetailbyId = ListApiConstant().apiMenuDetail;
  final String apiMenuCategory = ListApiConstant().apiMenuCategory;

  Future<String?> _getToken() async {
    final box = await Hive.openBox('venturo');
    final token = box.get('token', defaultValue: '');
    if (token.isEmpty) {
      print("⚠️ Token kosong! Coba login ulang.");
      return null;
    }
    return token;
  }

  Future<Map<String, dynamic>> fetchData(int offset) async {
    final token = await _getToken();
    if (token == null) return {'data': []};

    try {
      Response response = await Dio().get(apiMenu,
          queryParameters: {'offset': offset, 'limit': 10},
          options: Options(headers: {
            'token': token,
            'Content-Type': 'application/json',
          }));
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> fetchedData =
            List<Map<String, dynamic>>.from(
          response.data['data'].map((item) => {
                "id_menu": item['id_menu'] ?? 0,
                "nama": item['nama'] ?? "Tidak ada data",
                "kategori": item['kategori'] ?? "Tidak ada data",
                "harga": item['harga'] ?? 0,
                "deskripsi": item['deskripsi'] ?? "Tidak ada data",
                "foto": item['foto'] ??
                    "https://upload.wikimedia.org/wikipedia/commons/8/8c/NO_IMAGE_YET_square.png",
                "status": item['status'] ?? 1,
              }),
        );
        print("📦 Data berhasil diambil dari API {$fetchedData}");
        return {
          'data': fetchedData,
          'next': fetchedData.isNotEmpty ? true : null,
          'previous': offset > 0 ? true : null,
        };
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
    }
    return {'data': []};
  }

  // Get list of data
  Map<String, dynamic> getListOfData({int offset = 0}) {
    int limit = 5 + offset;
    if (limit > data.length) limit = data.length;

    return {
      'data': data.getRange(offset, limit).toList(),
      'next': limit < data.length ? true : null,
      'previous': offset > 0 ? true : null,
    };
  }

  // Delete item
  void deleteItem(int id) {
    data.removeWhere((element) => element['id_menu'] == id);
  }
}
