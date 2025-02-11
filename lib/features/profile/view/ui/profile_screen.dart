import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/tile_option_widget.dart';
import '../../constants/profile_assets_constant.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final assetsConstant = ProfileAssetsConstant();
  // final ProfileController pc = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile Screen'),
            Divider(),
            TileOptionWidget(
              title: 'Privacy Policy'.tr,
              message: 'Here',
              onTap: ProfileController.to.privacyPolicyWebView,
            ),
            Divider(),
            Obx(() {
              return ListTile(
                title: Text(ProfileController.to.productName.value.isNotEmpty
                    ? 'Product Name: ${ProfileController.to.productName.value}'
                    : 'Loading...'),
                subtitle: Text(ProfileController.to.apiLevel.value.isNotEmpty
                    ? 'Android Version: ${ProfileController.to.apiLevel.value}'
                    : 'Loading...'),
              );
            }),
            Divider(),
            ElevatedButton(
              onPressed: () {
                ProfileController.to.logout();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
