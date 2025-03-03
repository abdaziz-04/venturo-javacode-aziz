import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/list/repositories/list_repository.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

class CheckoutEditMenuController extends GetxController {
  static CheckoutEditMenuController get to => Get.find();
  final ListDetailController detailController = ListDetailController.to;
  RxMap<String, dynamic> selectedMenuDetail = <String, dynamic>{}.obs;
  RxMap<String, dynamic> previousCartItem = <String, dynamic>{}.obs;
  RxMap<String, dynamic> cartItem = <String, dynamic>{}.obs;
  late final ListRepository repository;
  final RxMap<String, dynamic> selectedLevel = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> selectedToppings =
      <Map<String, dynamic>>[].obs;
  RxInt price = 0.obs;
  RxInt qty = 0.obs;

  @override
  void onInit() {
    super.onInit();
    repository = ListRepository();
    final arguments = Get.arguments;
    print('COController.onInit() - Arguments: $arguments');
    if (arguments != null) {
      getDetailMenu(arguments);
    } else {
      print('Argument tidak valid atau tidak mengandung id_menu.');
    }
    saveCartItemById(arguments);
    getQty();
  }

  void saveCartItemById(int idMenu) {
    final Map<String, dynamic> item = CheckoutController.to.cartItem.firstWhere(
        (element) => element['id_menu'] == idMenu,
        orElse: () => {});

    if (item.isNotEmpty) {
      previousCartItem.assignAll(item);
      print("Data tersimpan: $previousCartItem");
    } else {
      print("Item dengan id_menu $idMenu tidak ditemukan.");
    }
  }

  Future<void> getDetailMenu(int id) async {
    selectedMenuDetail.value = {};
    try {
      final result = await repository.fetchDetailMenu(id);
      if (result.isNotEmpty) {
        selectedMenuDetail.value = result;
        print("📦 Detail menu: $selectedMenuDetail");
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

  void addLevel(Map<String, dynamic> level) {
    selectedLevel.value = level;
    print('👌Selected level: $level');
  }

  void getQty() {
    qty.value = previousCartItem['jumlah'];
    print('📦 Jumlah: $qty');
  }

  void addTopping(Map<String, dynamic> topping) {
    if (!selectedToppings
        .any((element) => element['id_detail'] == topping['id_detail'])) {
      selectedToppings.add(topping);
    }
    print('👌 Selected toppings: $selectedToppings');
  }

  void getPrice() {
    int basePrice = (selectedMenuDetail['menu']?['harga'] as int?) ?? 0;
    int levelPrice = (selectedLevel['harga'] as int?) ?? 0;
    int toppingPrice = selectedToppings.fold<int>(
      0,
      (prev, element) => prev + (element['harga'] as int? ?? 0),
    );
    price.value = (basePrice + levelPrice + toppingPrice) * qty.value;
    print('💰 Harga: ${price.value}');
  }

  void updateCart() {
    final newData = {
      'harga': price.value,
      'totalHarga': price.value,
      'level': selectedLevel['keterangan'],
      'topping':
          selectedToppings.map((topping) => topping['id_detail']).toList(),
      'jumlah': qty.value,
    };

    final index = CheckoutController.to.cartItem.indexWhere(
      (item) => item['id_menu'] == previousCartItem['id_menu'],
    );

    if (index != -1) {
      CheckoutController.to.cartItem[index] = {
        ...CheckoutController.to.cartItem[index],
        ...newData,
      };
      CheckoutController.to.calculateTotalPrice();
      Get.back();
      print(
          '🛒 Keranjang berhasil di‑update: ${CheckoutController.to.cartItem[index]}');
    } else {
      print(
          '🚨 Item dengan id_menu ${previousCartItem['id_menu']} tidak ditemukan di keranjang.');
    }
  }
}
