import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RatingController extends GetxController {
  static RatingController get to => Get.find();
  final RxList<Map<String, dynamic>> rateItem = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRate();
  }

  void getRate() {
    rateItem.clear();
    final ratingBox = Hive.box('rating');
    rateItem.addAll(ratingBox.values.cast<Map<String, dynamic>>());
    print('🛒 Isi rate dari Hive box: $rateItem');
  }

  void deleteAllRate() {
    final ratingBox = Hive.box('rating');
    ratingBox.clear();
    rateItem.clear();
    print('🗑️ Semua rate dihapus');
  }
}
