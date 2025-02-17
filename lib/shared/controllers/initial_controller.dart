import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../configs/routes/route.dart';
import '../../features/initial/view/ui/get_location_screen.dart';

import '../../features/splash/view/ui/location_disabled_screen.dart';
import '../../utils/services/location_service.dart';

class InitialController extends GetxController {
  static InitialController get to => Get.find();
  var isLocationEnabled = false.obs;
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  @override
  void onReady() {
    super.onReady();
    checkLocationService();
    getLocation();
    LocationServices.streamService.listen((status) => getLocation());
  }

  Future<void> checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    isLocationEnabled.value = serviceEnabled;
    if (!serviceEnabled) {
      Get.to(LocationDisabledScreen());
    } else {
      getLocation();
    }
  }

  Future<void> getLocation() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(GetLocationScreen(), barrierDismissible: false);
    }

    try {
      /// Mendapatkan Lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        // Get.until(ModalRoute.withName(Routes.profileRoute));
        Get.offAllNamed(Routes.homeRoute);

        print("Current Route: ${Get.currentRoute}");
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
