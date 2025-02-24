import 'package:get/get.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';

import '../controllers/sig_in_controller.dart';

class SigInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SigInController());
  }
}
