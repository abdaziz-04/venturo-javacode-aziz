import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/splash/constants/splash_assets_constant.dart';

import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashController sc = Get.put(SplashController());

  final assetsConstant = SplashAssetsConstant();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    analytics.logEvent(
      name: 'splash_screen_viewed',
      parameters: <String, Object>{
        'screen': 'SplashScreen',
        'time': DateTime.now().toString(),
      },
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage(assetsConstant.logo),
                width: 200,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
