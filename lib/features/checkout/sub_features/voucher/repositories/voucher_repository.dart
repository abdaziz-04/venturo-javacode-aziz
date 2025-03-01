import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/checkout/constants/checkout_api_constant.dart';
import 'package:venturo_core/shared/controllers/global_controller.dart';

class VoucherRepository {
  VoucherRepository();
  final GlobalController globalController = GlobalController();
  final List<Map<String, dynamic>> voucher = [];

  var apiConstant = CheckoutApiConstant();

  Future<String?> _getToken() async {
    final box = await Hive.openBox('user');
    final token = box.get('token', defaultValue: '');
    if (token.isEmpty) {
      print("⚠️ Token kosong! Coba login ulang.");
      return null;
    }
    return token;
  }

  Future<Map<String, dynamic>> fetchAllVoucher() async {
    final token = await _getToken();
    if (token == null) return {'data': []};

    try {
      dio.Response response = await dio.Dio().get(
        apiConstant.allVoucherApi,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> fetchedData =
            List<Map<String, dynamic>>.from(
          response.data['data'].map((item) => {
                "id_voucher": item['id_voucher'] ?? 0,
                "nama": item['nama'] ?? "Tidak ada data",
                "id_user": item['id_user'] ?? 0,
                "nama_user": item['nama_user'] ?? "Tidak ada data",
                "nominal": item['nominal'] ?? 0,
                "info_voucher": item['info_voucher'] ??
                    "https://img.freepik.com/free-photo/high-angle-uncompleted-voting-questionnaire_23-2148265549.jpg?semt=ais_hybrid",
                "periode_mulai": item['periode_mulai'] ?? "",
                "periode_selesai": item['periode_selesai'] ?? "",
                "type": item['type'] ?? 0,
                "status": item['status'] ?? 0,
                "catatan": item['catatan'] ?? "Tidak ada data",
              }),
        );
        print("📦 Data voucher berhasil diambil dari API {$fetchedData}");
        return {'data': fetchedData};
      } else if (response.statusCode == 204) {
        return {'data': []};
      }
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      print("🚨 Error saat fetch data voucher: $e");
    }
    return {'data': []};
  }
}
