import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';

import '../../list/controllers/list_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ListDetailController());
    Get.put(ListController());
    Get.put(ProfileController());
  }
}
