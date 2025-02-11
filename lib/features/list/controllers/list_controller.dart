import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find();

  final ListRepository _repository = ListRepository();

  // Untuk detail data (dipakai di halaman detail)
  final Rx<Map<String, dynamic>?> selectedMenuApi =
      Rx<Map<String, dynamic>?>(null);
  final isLoading = false.obs;

  // Daftar item menu
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;

  // Properti tambahan untuk tampilan list
  final List<String> categories = ['all', 'makanan', 'minuman'];
  final RxString selectedCategory = 'all'.obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxBool canLoadMore = true.obs;

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
    await ListRepository;
  }

  /// Mengambil detail data menu berdasarkan id (dipakai di halaman detail)
  Future<void> fetchDetail(int id) async {
    isLoading.value = true;
    final data = await _repository.getDataByDetail(id);
    selectedMenuApi.value = data;
    isLoading.value = false;
    print('👌Detail data: $data');
  }

  /// Mengambil seluruh data menu
  Future<void> fetchAllData() async {
    isLoading.value = true;
    items.value = await _repository.getAllData();
    isLoading.value = false;
  }

  /// Mengambil data berdasarkan kategori tertentu
  Future<void> refreshDataByCategory(String category) async {
    isLoading.value = true;
    items.value = await _repository.getDataByCategory(category);
    isLoading.value = false;
  }

  /// Fungsi untuk refresh (pull-to-refresh)
  Future<void> onRefresh() async {
    isLoading.value = true;
    if (selectedCategory.value == 'all') {
      await fetchAllData();
    } else {
      await refreshDataByCategory(selectedCategory.value);
    }
    refreshController.refreshCompleted();
    isLoading.value = false;
  }

  /// Fungsi ketika kategori dipilih dari chip
  void selectCategory(String category) async {
    isLoading.value = true;
    selectedCategory.value = category;
    if (category == 'all') {
      await fetchAllData();
    } else {
      await refreshDataByCategory(category);
    }
    isLoading.value = false;
  }

  /// Fungsi hapus item
  Future<void> deleteItemApi(Map<String, dynamic> itemToDelete) async {
    isLoading.value = true;
    bool success = await _repository.deleteItem(itemToDelete);
    if (success) {
      items.removeWhere((item) => item['id_menu'] == itemToDelete['id_menu']);
    }
    isLoading.value = false;
  }
}
