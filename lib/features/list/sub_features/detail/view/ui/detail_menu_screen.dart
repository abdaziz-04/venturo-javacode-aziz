import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../controllers/list_controller.dart';
import '../components/app_bar.dart';
import '../components/info_row.dart';

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
                          InfoRow(
                            icon: Icons.money_sharp,
                            label: 'Harga',
                            value: "Rp ${menu['harga']}",
                          ),
                          InfoRow(
                            icon: Icons.star,
                            label: 'Level',
                            value: menu['level'].toString(),
                          ),
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
