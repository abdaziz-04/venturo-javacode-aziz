import 'package:get/get.dart';

import '../controllers/sig_in_controller.dart';

class SigInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SigInController());
  }
}
