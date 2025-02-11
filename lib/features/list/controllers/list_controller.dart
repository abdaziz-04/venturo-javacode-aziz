import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find();

  final ListRepository _repository = ListRepository();

  // Untuk detail data (dipakai di halaman detail)
  final Rx<Map<String, dynamic>?> selectedMenuApi =
      Rx<Map<String, dynamic>?>(null);

  // Daftar item menu
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;

  // Properti tambahan untuk tampilan list
  final List<String> categories = ['all', 'makanan', 'minuman'];
  final RxString selectedCategory = 'all'.obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxBool canLoadMore = true.obs;

  // Computed property untuk filtered list (misal, nanti bisa ditambahkan filter berdasarkan pencarian)
  List<Map<String, dynamic>> get filteredListApi => items;

  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments is int) {
        final int id = Get.arguments as int;
        await fetchDetail(id);
      }
    }

    await fetchAllData();
  }

  /// Mengambil detail data menu berdasarkan id (dipakai di halaman detail)
  Future<void> fetchDetail(int id) async {
    final data = await _repository.getDataByDetail(id);
    selectedMenuApi.value = data;
  }

  /// Mengambil seluruh data menu
  Future<void> fetchAllData() async {
    items.value = await _repository.getAllData();
  }

  /// Mengambil data berdasarkan kategori tertentu
  Future<void> refreshDataByCategory(String category) async {
    items.value = await _repository.getDataByCategory(category);
  }

  /// Fungsi untuk refresh (pull-to-refresh)
  Future<void> onRefresh() async {
    if (selectedCategory.value == 'all') {
      await fetchAllData();
    } else {
      await refreshDataByCategory(selectedCategory.value);
    }
    refreshController.refreshCompleted();
  }

  /// Fungsi ketika kategori dipilih dari chip
  void selectCategory(String category) async {
    selectedCategory.value = category;
    if (category == 'all') {
      await fetchAllData();
    } else {
      await refreshDataByCategory(category);
    }
  }

  /// Fungsi hapus item
  Future<void> deleteItemApi(Map<String, dynamic> itemToDelete) async {
    bool success = await _repository.deleteItem(itemToDelete);
    if (success) {
      items.removeWhere((item) => item['id_menu'] == itemToDelete['id_menu']);
    }
  }
}
