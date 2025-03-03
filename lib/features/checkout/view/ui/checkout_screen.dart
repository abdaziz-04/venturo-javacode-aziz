// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/view/components/checkout_menu_card.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';
import 'package:venturo_core/shared/widgets/info_row.dart';

import 'package:venturo_core/shared/widgets/title_section.dart';

import '../../../../configs/routes/route.dart';
import '../../../../constants/cores/assets/image_constants.dart';
import '../../../../shared/styles/color_style.dart';
import '../../../../shared/styles/elevated_button_style.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../constants/checkout_assets_constant.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  final assetsConstant = CheckoutAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        print('Pin: ${CheckoutController.to.pin}');
        CheckoutController.to.getPin();
        print('Pin update: ${CheckoutController.to.pin}');
      }),
      appBar: CustomAppBar(
        title: 'Pesanan',
        showActions: true,
        icon: Icons.delete,
        onPress: () {
          Get.defaultDialog(
            title: 'Hapus Semua Pesanan',
            middleText: 'Apakah anda yakin ingin menghapus semua pesanan?',
            textConfirm: 'Ya',
            textCancel: 'Tidak',
            buttonColor: ColorStyle.primary,
            confirmTextColor: ColorStyle.white,
            cancelTextColor: ColorStyle.primary,
            onConfirm: () {
              Get.back();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                CheckoutController.to.deleteAllCart();
                ListDetailController.to.deleteAllCart();
              });
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final List<Map<String, dynamic>> makananItems =
                      CheckoutController.to.cartItem.where((item) {
                    if (item == null || item['kategori'] == null) return false;
                    final kategori = item['kategori'].toString().toLowerCase();
                    return kategori == 'makanan';
                  }).toList();

                  if (makananItems.isEmpty) return Container();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSection(
                        title: 'Makanan',
                        image: ImageConstants.iconFood,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: makananItems.length,
                        itemBuilder: (context, index) {
                          final item = makananItems[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CheckoutMenuCard(
                                menu: item,
                                onTap: () => Get.toNamed(
                                    Routes.checkoutEditMenuRoute,
                                    arguments: item['id_menu'])),
                          );
                        },
                      ),
                    ],
                  );
                }),
                Obx(() {
                  final List<Map<String, dynamic>> minumanItems =
                      CheckoutController.to.cartItem.where((item) {
                    if (item == null || item['kategori'] == null) return false;
                    final kategori = item['kategori'].toString().toLowerCase();
                    return kategori == 'minuman';
                  }).toList();
                  if (minumanItems.isEmpty) {
                    return Container();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSection(
                        title: 'Minuman',
                        image: ImageConstants.iconDrinks,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: minumanItems.length,
                        itemBuilder: (context, index) {
                          final item = minumanItems[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CheckoutMenuCard(
                                menu: item,
                                onTap: () => Get.toNamed(
                                    Routes.checkoutEditMenuRoute,
                                    arguments: item['id_menu'])),
                          );
                        },
                      ),
                    ],
                  );
                }),
                Obx(() {
                  final List<Map<String, dynamic>> snackItems =
                      ListDetailController.to.cartItem.where((item) {
                    final kategori = item['kategori'].toString().toLowerCase();
                    return kategori == 'snack';
                  }).toList();
                  if (snackItems.isEmpty) {
                    return Container();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSection(
                        title: 'Snack',
                        image: ImageConstants.iconFood,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snackItems.length,
                        itemBuilder: (context, index) {
                          final item = snackItems[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CheckoutMenuCard(menu: item),
                          );
                        },
                      ),
                    ],
                  );
                }),
              ],
            )),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadius.circular(30),
        ),
        // height: 100,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15.h),
            Obx(() => InfoRow(
                  info: 'Total Pesanan :',
                  value: 'Rp ${CheckoutController.to.totalPrice}',
                  isBold: true,
                  valueColor: ColorStyle.primary,
                  containButton: false,
                  isImportant: true,
                )),
            const Divider(),
            Obx(() => InfoRow(
                  info: 'Diskon 20%',
                  value: '- Rp ${CheckoutController.to.discount}',
                  containImage: true,
                  valueColor: ColorStyle.danger,
                  image: ImageConstants.icDiscount,
                  onPress: () {
                    CheckoutController.to.showDiscountDialog();
                  },
                )),
            const Divider(),
            Obx(() => InfoRow(
                info: 'Voucher',
                value: CheckoutController.to.voucherPrice == 0
                    ? 'Pilih Voucher'
                    : '- Rp ${CheckoutController.to.voucherPrice}',
                containImage: true,
                image: ImageConstants.icVoucher,
                valueColor: CheckoutController.to.voucherPrice == 0
                    ? ColorStyle.dark
                    : ColorStyle.danger,
                onPress: () {
                  Get.toNamed(Routes.checkoutVoucherRoute);
                })),
            const Divider(),
            InfoRow(
                info: 'Pembayaran',
                value: 'Tunai',
                containButton: false,
                containImage: true,
                image: ImageConstants.icPayment),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: ColorStyle.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorStyle.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      ImageConstants.icCart,
                      width: 50.w,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                        Obx(() => Text(
                              'Rp ${CheckoutController.to.finalTotalPrice}',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorStyle.primary,
                              ),
                            )),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                        style: EvelatedButtonStyle.mainRounded,
                        onPressed: () {
                          print('🛒 Pesan Sekarang');
                          CheckoutController.to.showFingerprintDialog();
                        },
                        child: Text('Pesan Sekarang'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
