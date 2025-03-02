import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/checkout/bindings/checkout_binding.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/bindings/Checkout_edit_menu_binding.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/ui/edit_menu_screen.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/ui/detail_voucher_screen.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/ui/voucher_screen.dart';
import 'package:venturo_core/features/checkout/view/ui/checkout_screen.dart';
import 'package:venturo_core/features/forgot_password/bindings/otp_binding.dart';
import 'package:venturo_core/features/forgot_password/view/ui/forgot_password_screen.dart';
import 'package:venturo_core/features/forgot_password/view/ui/otp_screen.dart';
import 'package:venturo_core/features/home/bindings/home_binding.dart';
import 'package:venturo_core/features/home/view/ui/home_screen.dart';
import 'package:venturo_core/features/list/sub_features/detail/bindings/detail_binding.dart';
import 'package:venturo_core/features/list/sub_features/promo_detail/view/ui/promo_detail_screen.dart';
import 'package:venturo_core/features/no_connection/view/ui/no_connection_screen.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/bindings/DetailOrderBinding.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/view/ui/detail_order_screen.dart';
import 'package:venturo_core/features/order/view/ui/order_screen.dart';

import 'package:venturo_core/features/profile/view/ui/profile_screen.dart';
import 'package:venturo_core/features/rating/bindings/rating_binding.dart';
import 'package:venturo_core/features/rating/sub_features/add_rate/view/ui/add_rate_screen.dart';
import 'package:venturo_core/features/rating/sub_features/review_reply/view/ui/review_reply_screen.dart';
import 'package:venturo_core/features/rating/view/ui/rating_screen.dart';
import 'package:venturo_core/features/sig_in/view/ui/sig_in_screen.dart';
import 'package:venturo_core/features/splash/bindings/splash_binding.dart';
import 'package:venturo_core/features/splash/view/ui/splash_screen.dart';

import '../../features/forgot_password/bindings/forgot_password_binding.dart';
import '../../features/initial/view/ui/get_location_screen.dart';
import '../../features/list/bindings/list_binding.dart';
import '../../features/list/sub_features/detail/view/ui/detail_menu_screen.dart';
import '../../features/list/sub_features/promo_detail/bindings/promo_detail_binding.dart';
import '../../features/list/view/ui/list_screen.dart';
import '../../features/profile/bindings/profile_binding.dart';
import '../../features/profile/view/components/privacy_policy_view.dart';
import '../../shared/bindings/global_binding.dart';

abstract class Pages {
  static final pages = [
    GetPage(
        name: Routes.splashRoute,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.profileRoute,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.privacyPolicy,
      page: () => const PrivacyPolicyView(),
    ),
    GetPage(
      name: Routes.sigInRoute,
      page: () => SigIScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordRoute,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.listRoute,
      page: () => ListScreen(),
      binding: ListBinding(),
    ),
    GetPage(
      name: Routes.otpRoute,
      page: () => OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.getLocationScreenRoute,
      page: () => (GetLocationScreen()),
    ),
    GetPage(
      name: Routes.checkoutRoute,
      page: () => (CheckoutScreen()),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.promoDetailRoute,
      page: () => (PromoDetailScreen()),
      binding: PromoDetailBinding(),
    ),
    GetPage(
        name: Routes.homeRoute,
        page: () => (HomeScreen()),
        binding: HomeBinding()),
    GetPage(
        name: Routes.noConnectionRoute,
        page: () => (NoConnectionScreen()),
        binding: GlobalBinding()),
    GetPage(
        name: Routes.detailMenuRoute,
        page: () => DetailMenuScreen(),
        binding: DetailBinding()),
    GetPage(
      name: Routes.checkoutEditMenuRoute,
      page: () => EditMenuScreen(),
      binding: CheckoutEditMenuBinding(),
    ),
    GetPage(
      name: Routes.voucherDetail,
      page: () => DetailVoucherScreen(),
    ),
    GetPage(
      name: Routes.orderDetailRoute,
      page: () => DetailOrderScreen(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: Routes.checkoutVoucherRoute,
      page: () => VoucherScreen(),
    ),
    GetPage(
      name: Routes.orderRoute,
      page: () => OrderScreen(),
    ),
    GetPage(
      name: Routes.addRateRoute,
      page: () => AddRateScreen(),
    ),
    GetPage(
      name: Routes.ratingRoute,
      page: () => RatingScreen(),
      binding: RatingBinding(),
    ),
    GetPage(
      name: Routes.reviewReplyRoute,
      page: () => ReviewReplyScreen(),
    ),
  ];
}
