import 'package:get/get.dart';

import '../../../controllers/list_controller.dart';

class ListPromoDetailController extends GetxController {
  static ListPromoDetailController get to => Get.find();
  final ListController listController = ListController.to;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    print('ListDetailController.onInit() - Arguments: $arguments');
    if (arguments != null) {
      listController.getDetailPromo(arguments);
    } else {
      print('Argument tidak valid atau tidak mengandung id_menu.');
    }
  }
}
