import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/list/constants/list_api_constant.dart';

class ListController extends GetxController {
  static ListController get to => Get.find();

  final RxInt page = 0.obs;

  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> selectedItem =
      <Map<String, dynamic>>[].obs;

  final RxBool canLoadMore = true.obs;

  final RxString selectedCategory = 'all'.obs;
  final RxString keyword = ''.obs;

  final Dio _dio = Dio();

  final String apiMenu = ListApiConstant().apiMenu;

  // List kategori
  final List<String> categories = [
    'All',
    'makanan',
    'minuman',
  ];

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  String token = '';

  final Rx<Map<String, dynamic>?> selectedMenuApi =
      Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() async {
    super.onInit();
    await getDataByCategory(selectedCategory.value.toLowerCase());
    await getAllData();
  }

  void onRefresh() async {
    await getDataByCategory(selectedCategory.value.toLowerCase());
    await getAllData();
    canLoadMore.value = false;
    refreshController.refreshCompleted();
  }

  Future<void> getAllData() async {
    try {
      final box = await Hive.openBox('venturo');
      final token = box.get('token', defaultValue: '');

      if (token.isEmpty) {
        print("⚠️ Token kosong! Coba login ulang.");
        return;
      }

      print("📢 Mengambil semua data menu");

      dio.Response response = await _dio.get(
        apiMenu,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Data berhasil diambil:");
        print(response.data);
        final result = response.data;
        if (result is Map &&
            result.containsKey('data') &&
            result['data'] is Iterable) {
          items.clear();
          items.addAll(List<Map<String, dynamic>>.from(result['data']));
          print("✅ Jumlah item: ${items.length}");
        } else {
          print("⚠️ Format data tidak sesuai!");

          items.clear();
        }
      } else if (response.statusCode == 204) {
        print("✅ Data kosong");
        items.clear();
      } else {
        print("❌ Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error saat fetch data: $e");
    }
  }

  Future<void> getDataByCategory(String category) async {
    try {
      final box = await Hive.openBox('venturo');
      final token = box.get('token', defaultValue: '');

      if (token.isEmpty) {
        print("⚠️ Token kosong! Coba login ulang.");
        return;
      }

      final String url = ListApiConstant().apiMenuCategory + category;
      print("📢 Mengambil data untuk kategori: $category");
      print("📢 URL: $url");

      dio.Response response = await _dio.get(
        url,
        options: Options(headers: {
          'token': token,
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Data kategori $category berhasil diambil:");
        print(response.data);
        final result = response.data;
        if (result is Map &&
            result.containsKey('data') &&
            result['data'] is Iterable) {
          items.clear();
          items.addAll(List<Map<String, dynamic>>.from(result['data']));
          print("✅ Jumlah item: ${items.length}");
        } else {
          print("⚠️ Format data tidak sesuai!");

          items.clear();
        }
      } else if (response.statusCode == 204) {
        print("✅ Data kategori $category berhasil diambil: Data kosong");
        items.clear();
      } else {
        print(
            "❌ Gagal mengambil data kategori $category: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error saat fetch data kategori: $e");
    }
  }

  /// Filter data sesuai keyword dan kategori
  List<Map<String, dynamic>> get filteredListApi => items.where((element) {
        final name = element['nama']?.toString().toLowerCase() ?? '';
        final category = element['kategori']?.toString().toLowerCase() ?? '';
        final keywordLower = keyword.value.toLowerCase();
        final selectedCatLower = selectedCategory.value.toLowerCase();

        return name.contains(keywordLower) &&
            (selectedCatLower == 'all' || category == selectedCatLower);
      }).toList();

  void onItemTapApi(Map<String, dynamic> item) {
    selectedMenuApi.value = item;
  }

  Future<void> deleteItemApi(Map<String, dynamic> itemToDelete) async {
    try {
      final box = await Hive.openBox('venturo');
      final token = box.get('token', defaultValue: '');

      if (token.isEmpty) {
        print("⚠️ Token kosong! Coba login ulang.");
        return;
      }

      print("🗑️ Menghapus item ID: ${itemToDelete['id_menu']}");

      // Request ke API untuk menghapus item
      dio.Response response = await _dio.delete(
        "$apiMenu/${itemToDelete['id_menu']}",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Item berhasil dihapus!");

        items.removeWhere((item) => item['id_menu'] == itemToDelete['id_menu']);

        if (selectedMenuApi.value?['id_menu'] == itemToDelete['id_menu']) {
          selectedMenuApi.value = null;
        }
      } else {
        print("❌ Gagal menghapus item: ${response.data}");
      }
    } catch (exception, stacktrace) {
      print("🚨 Error saat delete item: $exception");
      await Sentry.captureException(exception, stackTrace: stacktrace);
    }
  }
}
