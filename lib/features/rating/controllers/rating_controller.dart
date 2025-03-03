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

    for (var item in ratingBox.values) {
      if (item is Map) {
        final mapItem = Map<String, dynamic>.from(
            item.map((key, value) => MapEntry(key.toString(), value)));
        rateItem.add(mapItem);
      } else {
        print('Data tidak sesuai format Map<String, dynamic>: $item');
      }
    }

    print('🛒 Isi rate dari Hive box: $rateItem');
  }

  void deleteAllRate() {
    final ratingBox = Hive.box('rating');
    ratingBox.clear();
    rateItem.clear();
    print('🗑️ Semua rate dihapus');
  }
}
