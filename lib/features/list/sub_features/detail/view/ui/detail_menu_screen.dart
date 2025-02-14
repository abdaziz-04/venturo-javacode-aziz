import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/detail/view/components/notes_bottom_sheet.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../controllers/list_controller.dart';
import '../components/app_bar.dart';
import '../components/info_row.dart';
import '../components/modal_bottom_sheet.dart';

class DetailMenuScreen extends StatelessWidget {
  DetailMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;
    final controller = ListController.to;

    controller.fetchDetail(item['id_menu']);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarD(),
            const SizedBox(height: 20),
            Obx(() {
              final detailData = controller.selectedMenuApi.value;
              final menu = detailData?['menu'];

              return Image.network(
                menu?['foto'] ?? '',
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 181,
                    child: Center(child: Icon(Icons.broken_image)),
                  );
                },
              );
            }),
            const SizedBox(height: 10),
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
                child: SingleChildScrollView(
                  child: Obx(() {
                    final detailData = controller.selectedMenuApi.value;
                    final menu = detailData?['menu'];
                    final List<dynamic> topping = detailData?['topping'] ?? [];
                    final List<dynamic> level = detailData?['level'] ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu?['nama'] ?? 'Nama tidak tersedia',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ColorStyle.primary,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  SizedBox(
                                    width: 250.w,
                                    child: Text(
                                      menu?['deskripsi'] ??
                                          'Deskripsi tidak tersedia',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: ColorStyle.primary,
                                  ),
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: ColorStyle.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
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
                              "Rp ${menu?['harga'] ?? '0'}",
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
                          value: (level.isNotEmpty &&
                                  level[0]['keterangan'] != null)
                              ? level[0]['keterangan'].toString()
                              : 'Tidak ada level',
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return ModalBottomSheet(
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
                          value: (topping.isNotEmpty &&
                                  topping[0]['keterangan'] != null)
                              ? topping[0]['keterangan'].toString()
                              : 'Tidak ada toping',
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return ModalBottomSheet(
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
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            backgroundColor: ColorStyle.primary,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          onPressed: () {},
                          child: Text('Tambahkan Ke Pesanan'),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
