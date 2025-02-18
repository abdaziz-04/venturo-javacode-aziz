import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/view/ui/list_screen.dart';
import 'package:venturo_core/features/profile/view/ui/profile_screen.dart';

import '../../../../shared/widgets/c_bottom_app_bar.dart';
import '../../constants/home_assets_constant.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final assetsConstant = HomeAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(() => IndexedStack(
            index: HomeController.to.tabIndex.value,
            children: [ListScreen(), Text('Pesanan'), ProfileScreen()],
          )),
      bottomNavigationBar: CBottomAppBar(),
    ));
  }
}
