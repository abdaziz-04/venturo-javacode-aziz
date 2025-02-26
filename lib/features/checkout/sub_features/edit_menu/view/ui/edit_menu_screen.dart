import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/checkout_edit_menu_controller.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/features/list/sub_features/detail/view/components/topping_modal_bottom_sheet%20.dart';
import 'package:venturo_core/shared/widgets/custom_app_bar.dart';

import '../../../../../../shared/styles/color_style.dart';
import '../../../../../list/sub_features/detail/controllers/list_detail_controller.dart';
import '../../../../../list/sub_features/detail/view/components/info_row.dart';
import '../../../../../list/sub_features/detail/view/components/level_modal_bottom_sheet.dart';
import '../../../../../list/sub_features/detail/view/components/notes_bottom_sheet.dart';

import '../../../../constants/checkout_assets_constant.dart';

class EditMenuScreen extends StatelessWidget {
  EditMenuScreen({Key? key}) : super(key: key);

  final controller = CheckoutEditMenuController.to;
  final int idMenu = Get.arguments as int;
  final assetsConstant = CheckoutAssetsConstant();

  final Map<String, dynamic> editData = {
    'nama': 'Lemon Tea',
    'foto': 'https://javacode.landa.id/img/menu/gambar_62660e379fdf4.png',
    'deskripsi':
        'Minuman segar dengan perasan lemon alami, sangat menyegarkan di siang hari.',
    'harga': 27000,
    'level': [
      {'keterangan': 'Level 1'},
      {'keterangan': 'Level 2'},
    ],
    'topping': [
      {'keterangan': 'Boba'},
      {'keterangan': 'Jelly'},
    ],
    'jumlah': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Menu',
        showActions: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Print idMenu: $idMenu');
          controller.printCartContents();
        },
        child: Icon(Icons.bug_report_outlined),
        backgroundColor: ColorStyle.primary,
      ),
      body: Column(
        children: [
          // Bagian gambar menu
          Container(
            height: 150,
            child: CachedNetworkImage(
              imageUrl: editData['foto'],
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const SizedBox(
                height: 181,
                child: Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          // Bagian detail menu
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: Nama dan Jumlah
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        editData['nama'] ?? 'Nama tidak tersedia',
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
                              // Aksi dummy: kurangi jumlah
                              print('Kurangi jumlah');
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: ColorStyle.primary,
                            ),
                          ),
                          Text(
                            '${editData['jumlah']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              // Aksi dummy: tambah jumlah
                              print('Tambah jumlah');
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
                  // Deskripsi menu
                  Text(
                    editData['deskripsi'] ?? 'Deskripsi tidak tersedia',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.h),
                  // Row: Harga
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
                      Spacer(),
                      Text(
                        'Rp. ${editData['harga']}',
                        style: TextStyle(
                          fontSize: 18.w,
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.primary,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  // InfoRow untuk Level
                  InfoRow(
                    icon: Icons.star,
                    label: 'Level',
                    value: (editData['level'] != null &&
                            editData['level'].isNotEmpty)
                        ? editData['level'][0]['keterangan']
                        : 'Pilih Level',
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return LevelModalBottomSheet(
                            title: 'Pilih Level',
                            items: editData['level'] ?? [],
                          );
                        },
                      );
                    },
                  ),
                  const Divider(),

                  InfoRow(
                    icon: Icons.fastfood,
                    label: 'Toping',
                    value: (editData['topping'] != null &&
                            editData['topping'].isNotEmpty)
                        ? editData['topping'][0]['keterangan']
                        : 'Pilih Toping',
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ToppingModalBottomSheet(
                            title: 'Pilih Toping',
                            items: editData['topping'] ?? [],
                          );
                        },
                      );
                    },
                  ),
                  const Divider(),
                  // InfoRow untuk Catatan
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
              ),
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
                  // Aksi dummy simpan data
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
