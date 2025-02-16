import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../controllers/list_controller.dart';

class ListDetailController extends GetxController {
  static ListDetailController get to => Get.find();
  final ListController listController = ListController.to;
  RxInt qty = 1.obs;
  var selectedLevel = ''.obs;
  var selectedTopping = ''.obs;
  final cart = Hive.box('cart');

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print('ListDetailController.onInit() - Arguments: $arguments');
    if (arguments != null) {
      listController.getDetailMenu(arguments);
    } else {
      print('Argument tidak valid atau tidak mengandung id_menu.');
    }
  }

  void addToCart(int idMenu) {
    final cartItem = {
      'id_menu': idMenu,
      'quantity': qty.value,
      'level': selectedLevel.value,
      'topping': selectedTopping.value,
    };
    cart.add(cartItem);
    print('🛒 Berhasil ditambahkan $cartItem');
  }
}
