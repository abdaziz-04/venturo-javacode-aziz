import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();

  late final ListRepository repository;

  final RxInt page = 0.obs;

  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> promo = <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> selectedItems =
      <Map<String, dynamic>>[].obs;

  final RxBool canLoadMore = true.obs;

  final RxString selectedCategory = 'all'.obs;

  final RxString keyword = ''.obs;

  final List<String> categories = [
    'All',
    'Makanan',
    'Minuman',
  ];

  RxMap<String, dynamic> selectedMenuDetail = <String, dynamic>{}.obs;
  RxMap<String, dynamic> selectedPromoDetail = <String, dynamic>{}.obs;

  final RefreshController cRefresh = RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    super.onInit();

    repository = ListRepository();
    await getAllPromo();
    await getListOfData();
  }

  void onRefresh() async {
    page(0);
    canLoadMore(true);

    final result = await getListOfData();

    if (result) {
      cRefresh.refreshCompleted();
    } else {
      cRefresh.refreshFailed();
    }
  }

  List<Map<String, dynamic>> get filteredList => items
      .where((element) =>
          element['nama']
              .toString()
              .toLowerCase()
              .contains(keyword.value.toLowerCase()) &&
          (selectedCategory.value == 'all' ||
              element['kategori'] == selectedCategory.value))
      .toList();

  Future<bool> getAllPromo() async {
    try {
      final result = await repository.fetchAllPromo();
      print('📦 Data promo berhasil diambil dari API {$result}');

      if (result['data'].isNotEmpty) {
        promo.clear();
        promo.addAll(result['data']);
        print('📦 Data promo berhasil disimpan ke promo: $promo');
      } else {
        print('📦 Data promo kosong');
      }

      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      return false;
    }
  }

  Future<void> getDetailPromo(int id) async {
    selectedPromoDetail.value = {};
    try {
      final result = await repository.fetchDetailPromo(id);
      if (result.isNotEmpty) {
        selectedPromoDetail.value = result;
        print(
            "📦 Detail promo berhasil disimpan ke selectedPromoDetail: $selectedPromoDetail");
      } else {
        print("📦 Detail promo kosong");
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      print("🚨 Error saat fetch detail promo: $exception");
    }
  }

  Future<bool> getListOfData() async {
    try {
      final result = await repository.fetchData(page.value * 10);
      print('📦 Data berhasil diambil dari API {$result}');

      if (page.value == 0) {
        items.clear();
      }

      if (result['data'].isEmpty) {
        canLoadMore(false);
        cRefresh.loadNoData();
        print('📦 Data kosong');
      } else {
        items.addAll(result['data']);
        print('📦 Data berhasil diambil dari API {$items}');
        page.value++;
        cRefresh.loadComplete();
      }

      return true;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      cRefresh.loadFailed();
      return false;
    }
  }

  Future<void> getDetailMenu(int id) async {
    selectedMenuDetail.value = {};
    try {
      final result = await repository.fetchDetailMenu(id);
      if (result.isNotEmpty) {
        selectedMenuDetail.value = result;
        print(
            "📦 Detail menu berhasil disimpan ke selectedMenuDetail: $selectedMenuDetail");
      } else {
        print("📦 Detail menu kosong");
      }
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      print("🚨 Error saat fetch detail menu: $exception");
    }
  }

  Future<void> deleteItem(Map<String, dynamic> item) async {
    try {
      repository.deleteItem(item['id_menu']);

      items.remove(item);

      selectedItems.remove(item);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}
