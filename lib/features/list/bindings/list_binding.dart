import 'package:get/get.dart';

import '../controllers/list_controller.dart';
import '../sub_features/detail/controllers/list_detail_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListController());
    Get.put(ListDetailController());
  }
}
