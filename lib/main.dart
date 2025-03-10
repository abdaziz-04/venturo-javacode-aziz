import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:venturo_core/shared/bindings/global_binding.dart';
import 'package:venturo_core/utils/translations/profile_translate.dart';
import 'configs/pages/page.dart';
import 'configs/themes/theme.dart';
import 'shared/controllers/global_controller.dart';

import 'utils/services/sentry_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Localstorage
  await Hive.initFlutter();
  await Hive.openBox("venturo");
  await Hive.openBox('cart');
  await Hive.openBox('user');
  await Hive.openBox('rating');

  // Firebase
  await Firebase.initializeApp();

  Get.put(GlobalController());

  /// Change your options.dns with your project !!!!
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://30fca41e405dfa6b23883af045e4658e@o4505883092975616.ingest.sentry.io/4506539099095040';
      options.tracesSampleRate = 1.0;
      options.beforeSend = filterSentryErrorBeforeSend;
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Initial Screen',
      screenClassOverride: 'Trainee',
    );

    /// Screen Util Init berdasarkan ukuran iphone xr
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          translations: ProfileTranslate(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'Venturo Core',
          debugShowCheckedModeBanner: false,
          locale: Locale('id'),
          fallbackLocale: const Locale('id'),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('id'),
          ],
          initialBinding: GlobalBinding(),
          initialRoute: Routes.splashRoute,
          theme: themeLight,
          defaultTransition: Transition.native,
          getPages: Pages.pages,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
