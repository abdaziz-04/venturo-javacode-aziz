import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

import '../../../../../../shared/styles/color_style.dart';
import '../../../../../list/sub_features/detail/controllers/list_detail_controller.dart';
import '../../../../../list/sub_features/detail/view/components/info_row.dart';
import '../../../../../list/sub_features/detail/view/components/level_modal_bottom_sheet.dart';
import '../../../../../list/sub_features/detail/view/components/notes_bottom_sheet.dart';
import '../../../../../list/sub_features/detail/view/components/topping_modal_bottom_sheet .dart';
import '../../../../constants/checkout_assets_constant.dart';

class EditMenuScreen extends StatelessWidget {
  EditMenuScreen({Key? key}) : super(key: key);
  final controller = Get.find<ListController>();

  final assetsConstant = CheckoutAssetsConstant();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Menu',
        showActions: false,
      ),
      body: Column(
        children: [
          Obx(() {
            final detailData = controller.selectedMenuDetail.value;
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
          // Bagian detail menu
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
                final detailData = controller.selectedMenuDetail.value;
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
                        // Tambahkan skeleton lain sesuai kebutuhan layout
                      ],
                    ),
                  );
                }
                final menu = detailData['menu'];
                final List<dynamic> topping = detailData['topping'] ?? [];
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
                                if (ListDetailController.to.qty.value > 1) {
                                  ListDetailController.to.qty.value--;
                                  ListDetailController.to.getPrice();
                                }
                              },
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: ColorStyle.primary,
                              ),
                            ),
                            Obx(() => Text(
                                  ListDetailController.to.qty.toString(),
                                  style: TextStyle(fontSize: 18),
                                )),
                            IconButton(
                              onPressed: () {
                                ListDetailController.to.qty.value++;
                                ListDetailController.to.getPrice();
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
                          'Rp. ${ListDetailController.to.price.value != 0 ? ListDetailController.to.price.value : ListController.to.selectedMenuDetail.value['menu']['harga'] ?? 0}',
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
                      value: ListDetailController
                              .to.selectedLevel.value['keterangan'] ??
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
                      value: ListDetailController
                              .to.selectedTopping.value['keterangan'] ??
                          'Pilih Toping',
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ToppingModalBottomSheet(
                              title: 'Pilih Toping',
                              items: topping,
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
                  ],
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 20.h,
        ),
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
                onPressed: () {},
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
