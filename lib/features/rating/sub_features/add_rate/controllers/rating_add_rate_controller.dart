import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/features/rating/controllers/rating_controller.dart';

class RatingAddRateController extends GetxController {
  static RatingAddRateController get to => Get.find();
  TextEditingController reviewController = TextEditingController();
  final ratingBox = Hive.box('rating');

  final categories = [
    "Harga",
    "Rasa",
    "Penyajian makanan",
    "Pelayanan",
    "Fasilitas",
  ].obs;

  final selectedCategory = "".obs;
  final review = "".obs;
  final rating = 0.0.obs;
  final keterangan = "Cukup".obs;

  @override
  void onInit() {
    super.onInit();
    reviewController = TextEditingController();
  }

  void addReview() {
    review.value = reviewController.text;
    print('Review: ${review.value}');

    void updateKeterangan() {
      if (rating.value == 1) {
        keterangan.value = "Buruk";
      } else if (rating.value == 2) {
        keterangan.value = "Cukup";
      } else if (rating.value == 3) {
        keterangan.value = "Baik";
      } else if (rating.value == 4) {
        keterangan.value = "Sangat Baik";
      } else if (rating.value == 5) {
        keterangan.value = "Luar Biasa";
      }
      print('Keterangan: di update');
    }

    if (rating.value == 1) {
      keterangan.value = "Buruk";
    } else if (rating.value == 2) {
      keterangan.value = "Cukup";
    } else if (rating.value == 3) {
      keterangan.value = "Baik";
    } else if (rating.value == 4) {
      keterangan.value = "Sangat Baik";
    } else if (rating.value == 5) {
      keterangan.value = "Luar Biasa";
    }
    print('Keterangan: di update');
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void submit() {
    addReview();
    final data = {
      "category": selectedCategory.value,
      "rating": rating.value,
      "review": review.value,
    };
    ratingBox.add(data);
    RatingController.to.getRate();
    print('Data rating: $data');

    Get.back();
  }
}
