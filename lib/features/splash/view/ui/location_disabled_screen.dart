import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/initial/view/ui/get_location_screen.dart';

import '../../../../constants/cores/assets/image_constants.dart';

class LocationDisabledScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(ImageConstants.iconLocationDisabled),
              width: 400,
            ),
            const Text('Lokasi tidak aktif',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Geolocator.openLocationSettings();
                    },
                    icon: Icon(Icons.location_disabled),
                    label: Text('Aktifkan Lokasi')),
                SizedBox(width: 20),
                ElevatedButton.icon(
                    onPressed: () {
                      Get.to(GetLocationScreen());
                    },
                    icon: Icon(Icons.location_on),
                    label: Text('Sudah aktif')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
