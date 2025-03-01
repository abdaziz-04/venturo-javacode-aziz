import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/checkout_edit_menu_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/info_row.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/level_modal_bottom_sheet.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/notes_bottom_sheet.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/view/components/topping_modal_bottom_sheet%20.dart';

import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

import '../../../../../../shared/styles/color_style.dart';

import '../../../../constants/checkout_assets_constant.dart';

class EditMenuScreen extends StatelessWidget {
  EditMenuScreen({Key? key}) : super(key: key);

  final cController = CheckoutController.to;
  final ceController = CheckoutEditMenuController.to;
  final lController = ListDetailController.to;
  final idMenu = Get.arguments;
  final assetsConstant = CheckoutAssetsConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Menu',
        showActions: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Topping: ${ceController.selectedMenuDetail['topping']}');
          // print('Topping: ${ceController.selectedToppings.value}');
        },
        child: Icon(Icons.bug_report_outlined),
        backgroundColor: ColorStyle.primary,
      ),
      body: Column(
        children: [
          Obx(() {
            final detailData = ceController.selectedMenuDetail;
            if (detailData.isEmpty || detailData['menu'] == null) {
              return Container(
                width: double.infinity,
                height: 150,
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final menu = detailData['menu'];
            return CachedNetworkImage(
              imageUrl: menu?['foto'] ?? '',
              height: 150,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return const SizedBox(
                  height: 181,
                  child: Center(child: Icon(Icons.broken_image)),
                );
              },
            );
          }),
          SizedBox(height: 10.h),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 20.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(111, 24, 24, 24),
                    blurRadius: 15,
                    spreadRadius: -1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Obx(() {
                final detailData = ceController.selectedMenuDetail;
                if (detailData.isEmpty || detailData['menu'] == null) {
                  return Skeletonizer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24,
                          width: 150,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 16,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 20,
                          width: 50,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  );
                }
                final menu = detailData['menu'];
                // final List<dynamic> topping = detailData['topping'] ?? [];
                final List<dynamic> level = detailData['level'] ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          menu?['nama'] ?? 'Nama tidak tersedia',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.primary,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (ceController.qty.value > 1) {
                                  ceController.qty.value--;
                                  ceController.getPrice();
                                }
                              },
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: ColorStyle.primary,
                              ),
                            ),
                            Obx(() => Text(
                                  // ceController.qty.value.toString(),
                                  ceController.qty.value.toString(),
                                  style: TextStyle(fontSize: 18),
                                )),
                            IconButton(
                              onPressed: () {
                                ceController.qty.value++;
                                ceController.getPrice();
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: ColorStyle.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      menu?['deskripsi'] ?? 'Deskripsi tidak tersedia',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(
                          Icons.money_sharp,
                          color: ColorStyle.primary,
                          size: 20.w,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Harga',
                          style: TextStyle(
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Rp. ${ceController.price.value != 0 ? ceController.price.value : ceController.previousCartItem['harga'] ?? 0}',
                          // ceController.price.value.toString(),
                          style: TextStyle(
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.primary,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    InfoRow(
                      icon: Icons.star,
                      label: 'Level',
                      value: ceController.selectedLevel.isNotEmpty
                          ? ceController.selectedLevel['keterangan'] ??
                              'Pilih Level'
                          : ceController.previousCartItem['level'] ??
                              'Pilih Level',
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return LevelModalBottomSheet(
                              title: 'Pilih Level',
                              items: level,
                            );
                          },
                        );
                      },
                    ),
                    const Divider(),
                    InfoRow(
                      icon: Icons.fastfood,
                      label: 'Toping',
                      value: ceController.selectedToppings.isNotEmpty
                          ? ceController.selectedToppings.first['keterangan'] ??
                              'Pilih Toping'
                          : 'Pilih Toping',
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ToppingModalBottomSheet(
                              title: 'Pilih Toping',
                              items: ceController.selectedMenuDetail['topping'],
                            );
                          },
                        );
                      },
                    ),
                    const Divider(),
                    InfoRow(
                      icon: Icons.notes,
                      label: 'Catatan',
                      value: 'Tidak ada catatan',
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return NotesModalBottomSheet(
                              title: 'Catatan',
                            );
                          },
                        );
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(111, 24, 24, 24),
              blurRadius: 15,
              spreadRadius: -1,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ceController.updateCart();
                  print('Simpan data');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
