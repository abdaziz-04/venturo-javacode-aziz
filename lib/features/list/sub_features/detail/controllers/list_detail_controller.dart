import 'package:get/get.dart';

class ListDetailController extends GetxController {
  static ListDetailController get to => Get.find();

  var selectedMenu = {}.obs;
  var selectedToppings = <Map<String, dynamic>>[].obs;
  var selectedLevel = {}.obs;
  var totalPrice = 0.obs;

  // Total harga
  void calculateTotal() {
    int menuPrice = selectedMenu['harga'] ?? 0;

    int toppingPrice = 0;

    int levelPrice = selectedLevel['harga'] ?? 0;

    totalPrice.value = menuPrice + toppingPrice + levelPrice;
  }
}
