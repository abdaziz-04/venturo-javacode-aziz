import 'package:get/get.dart';
import 'package:venturo_core/features/rating/controllers/rating_controller.dart';
import 'package:venturo_core/features/rating/sub_features/add_rate/controllers/rating_add_rate_controller.dart';

class RatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RatingController());
    Get.put(RatingAddRateController());
  }
}
