import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/features/list/constants/list_api_constant.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ListRepository {
  final List<Map<String, dynamic>> data = [];
  final List<Map<String, dynamic>> dataPromo = [];
  final String apiMenu = ListApiConstant().apiMenu;
  final String apiDetailbyId = ListApiConstant().apiMenuDetail;
  final String apiMenuCategory = ListApiConstant().apiMenuCategory;
  final String apiAllPromo = ListApiConstant().apiPromoAll;
  final String apiDetailPromo = ListApiConstant().apiPromoDetail;

  Future<String?> _getToken() async {
    final box = await Hive.openBox('venturo');
    final token = box.get('token', defaultValue: '');
    if (token.isEmpty) {
      print("⚠️ Token kosong! Coba login ulang.");
      return null;
    }
    return token;
  }

  Future<Map<String, dynamic>> fetchDetailPromo(int id) async {
    final token = await _getToken();

    if (token == null) return {'data': []};
    final String url = "$apiDetailPromo$id";

    try {
      Response response = await Dio().get(
        url,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        print("📦 Data promo berhasil diambil dari API {$result}");
        if (result is Map && result.containsKey('data')) {
          final nama = result['data']['nama'];
          final sk = result['data']['syarat_ketentuan'];
          final foto = result['data']['foto'];
          return {
            'nama': nama ?? "Tidak ada data",
            'sk': sk ?? "Tidak ada data",
            'foto': foto ??
                "https://img.freepik.com/free-photo/high-angle-uncompleted-voting-questionnaire_23-2148265549.jpg?semt=ais_hybrid",
          };
        }
      } else if (response.statusCode == 204) {
        return {'data': []};
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print("🚨 Error saat fetch detail promo: $e");
    }
    return {'data': []};
  }

  Future<Map<String, dynamic>> fetchAllPromo() async {
    final token = await _getToken();
    if (token == null) return {'data': []};

    try {
      Response response = await Dio().get(
        apiAllPromo,
        options: Options(headers: {
          'token': 'ce7eaad890aa429494b00bf3019dfb4f2050958c',
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> fetchedData =
            List<Map<String, dynamic>>.from(
                response.data['data'].map((item) => {
                      "id_promo": item['id_promo'] ?? 0,
                      "nama": item['nama'] ?? "Tidak ada data",
                      "type": item['type'] ?? "Tidak ada data",
                      "diskon": item['diskon'],
                      "nominal": item['nominal'] ?? 0,
                      "kadaluarsa": item['kadaluarsa'],
                      "syarat_ketentuan":
                          item['syarat_ketentuan'] ?? "Tidak ada data",
                      "foto": item['foto'] ??
                          "https://img.freepik.com/free-photo/high-angle-uncompleted-voting-questionnaire_23-2148265549.jpg?semt=ais_hybrid",
                      "created_at": item['created_at'] ?? 0,
                      "created_by": item['created_by'] ?? 0,
                      "is_deleted": item['is_deleted'] ?? 0,
                    }));
        print("📦 Data berhasil diambil dari API {$fetchedData}");
        return {'data': fetchedData};
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print("🚨 Error saat fetch data promo: $e");
    }
    return {'data': []};
  }

  Future<Map<String, dynamic>> fetchDetailMenu(int id) async {
    final token = await _getToken();

    if (token == null) return {'data': []};
    final String url = "$apiDetailbyId$id";

    try {
      Response response = await Dio().get(
        url,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        print("📦 Data berhasil diambil dari API {$result}");
        if (result is Map && result.containsKey('data')) {
          final menuData = result['data']['menu'];
          final toppings =
              List<Map<String, dynamic>>.from(result['data']['topping']);
          final levels =
              List<Map<String, dynamic>>.from(result['data']['level']);
          return {
            'menu': menuData,
            'topping': toppings,
            'level': levels,
          };
        }
      } else if (response.statusCode == 204) {
        return {'data': []};
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      print("🚨 Error saat fetch detail data: $e");
    }
    return {'data': []};
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
