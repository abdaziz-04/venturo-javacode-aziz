import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

    ListController.to.fetchDetail(item['id_menu']);

    return SafeArea(
      child: Obx(() {
        final detailData = ListController.to.selectedMenuApi.value;

        final menu = detailData?['menu'];
        final List<dynamic> topping = detailData?['topping'];
        final List<dynamic> level = detailData?['level'];
        return Scaffold(
          body: Column(
            children: [
              AppBarD(),
              const SizedBox(height: 20),
              Image.network(
                menu?['foto'] ?? '',
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 181,
                    child: Center(child: Icon(Icons.broken_image)),
                  );
                },
              ),
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
                    child: Column(
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

                              // Counter jumlah item
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
                          const SizedBox(height: 80),
                          InfoRow(
                            icon: Icons.money_sharp,
                            label: 'Harga',
                            value: "Rp ${menu['harga']}",
                          ),
                          InfoRow(
                            icon: Icons.star,
                            label: 'Level',
                            value: (level.isNotEmpty &&
                                    level[0]['keterangan'] != null)
                                ? level[0]['keterangan'].toString()
                                : 'Tidak ada level',
                          ),
                          InfoRow(
                            icon: Icons.fastfood,
                            label: 'Toping',
                            value: (topping.isNotEmpty &&
                                    topping[0]['keterangan'] != null)
                                ? topping[0]['keterangan'].toString()
                                : 'Tidak ada toping',
                          ),
                          InfoRow(
                            icon: Icons.notes,
                            label: 'Catatan',
                            value: 'Tidak ada catatan',
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  backgroundColor: ColorStyle.primary,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 50.h)),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Pilih Level',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // ...level
                                            //     .map((lvl) => Text(
                                            //         lvl['keterangan'] ??
                                            //             'Tidak ada keterangan'))
                                            //     .toList(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text('Tambahkan Ke Pesanan')),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
