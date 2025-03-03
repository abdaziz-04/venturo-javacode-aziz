import 'package:get/get.dart';

class OrderDetailOrderController extends GetxController {
  static OrderDetailOrderController get to => Get.find();
  RxInt totalHarga = 0.obs;
  RxMap<String, dynamic> order = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments;
    getTotalPrice(data);
    order.value = data;
  }

  int getTotalPrice(Map<String, dynamic> data) {
    totalHarga.value = 0;
    if (data['menu'] != null && data['menu'] is List) {
      for (var item in data['menu']) {
        final dynamic itemTotal = item['total'];

        if (itemTotal is int) {
          totalHarga += itemTotal;
        } else if (itemTotal is String) {
          totalHarga += int.tryParse(itemTotal) ?? 0;
        }
      }
    }
    print(totalHarga);

    return totalHarga.value;
  }
}
