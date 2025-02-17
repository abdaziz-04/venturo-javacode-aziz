import 'package:get/get.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListDetailController>(() => ListDetailController());
  }
}
