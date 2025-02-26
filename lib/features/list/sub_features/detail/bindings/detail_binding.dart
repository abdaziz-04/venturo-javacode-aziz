import 'package:get/get.dart';

import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListDetailController(), permanent: true);
  }
}
