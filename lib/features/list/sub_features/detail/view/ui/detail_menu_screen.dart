import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';
import 'package:venturo_core/features/list/sub_features/detail/view/components/notes_bottom_sheet.dart';
import 'package:venturo_core/features/list/sub_features/detail/view/components/topping_modal_bottom_sheet%20.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

import '../../../../controllers/list_controller.dart';

import '../components/info_row.dart';
import '../components/level_modal_bottom_sheet.dart';
import '../components/modal_bottom_sheet.dart';

class DetailMenuScreen extends StatelessWidget {
  DetailMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;
    final controller = ListController.to;

    // controller.fetchDetail(item['id_menu']);

    return Placeholder(
        // appBar: AppBar(
        //   title: Text(
        //     'Detail Menu',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        //   backgroundColor: Colors.white,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(30.r),
        //     ),
        //   ),
        //   elevation: 15,
        //   shadowColor: Colors.black.withOpacity(0.5),
        //   centerTitle: true,
        // ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       const SizedBox(height: 20),
        //       SizedBox(
        //         height: 150.h,
        //         child: Obx(() {
        //           final detailData = controller.selectedMenuApi.value;
        //           final menu = detailData?['menu'];

        //           return Image.network(
        //             menu?['foto'] ?? '',
        //             fit: BoxFit.cover,
        //             errorBuilder: (context, error, stackTrace) {
        //               return const SizedBox(
        //                 height: 181,
        //                 child: Center(child: Icon(Icons.broken_image)),
        //               );
        //             },
        //           );
        //         }),
        //       ),
        //       const SizedBox(height: 10),
        //       Container(
        //         width: double.infinity,
        //         padding: EdgeInsets.symmetric(
        //           horizontal: 25.w,
        //           vertical: 20.h,
        //         ),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.vertical(
        //             top: Radius.circular(30.r),
        //           ),
        //           boxShadow: const [
        //             BoxShadow(
        //               color: Color.fromARGB(111, 24, 24, 24),
        //               blurRadius: 15,
        //               spreadRadius: -1,
        //               offset: Offset(0, 1),
        //             ),
        //           ],
        //         ),
        //         child: SingleChildScrollView(
        //           child: Obx(() {
        //             final detailData = controller.selectedMenuApi.value;
        //             final menu = detailData?['menu'];
        //             final List<dynamic> topping = detailData?['topping'] ?? [];
        //             final List<dynamic> level = detailData?['level'] ?? [];

        //             return Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Flexible(
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text(
        //                             menu?['nama'] ?? 'Nama tidak tersedia',
        //                             style: TextStyle(
        //                               fontSize: 24,
        //                               fontWeight: FontWeight.bold,
        //                               color: ColorStyle.primary,
        //                             ),
        //                           ),
        //                           SizedBox(height: 8.h),
        //                           SizedBox(
        //                             width: 250.w,
        //                             child: Text(
        //                               menu?['deskripsi'] ??
        //                                   'Deskripsi tidak tersedia',
        //                               overflow: TextOverflow.ellipsis,
        //                               maxLines: 3,
        //                             ),
        //                           ),
        //                           SizedBox(height: 16.h),
        //                         ],
        //                       ),
        //                     ),
        //                     Row(
        //                       children: [
        //                         IconButton(
        //                           onPressed: () {
        //                             controller.quantity.value--;
        //                           },
        //                           icon: Icon(
        //                             Icons.remove_circle_outline,
        //                             color: ColorStyle.primary,
        //                           ),
        //                         ),
        //                         Obx(() => Text(
        //                               controller.quantity.value.toString(),
        //                               style: TextStyle(fontSize: 18),
        //                             )),
        //                         IconButton(
        //                           onPressed: () {
        //                             controller.quantity.value++;
        //                           },
        //                           icon: Icon(
        //                             Icons.add_circle_outline,
        //                             color: ColorStyle.primary,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //                 const SizedBox(height: 30),
        //                 Row(
        //                   children: [
        //                     Icon(
        //                       Icons.money_sharp,
        //                       color: ColorStyle.primary,
        //                       size: 20.w,
        //                     ),
        //                     SizedBox(width: 10.w),
        //                     Text(
        //                       'Harga',
        //                       style: TextStyle(
        //                         fontSize: 18.w,
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     const Spacer(),
        //                     Obx(() => Text(
        //                           'Rp ${controller.totalPrice.value}',
        //                           style: TextStyle(
        //                             fontSize: 18.w,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         )),
        //                   ],
        //                 ),
        //                 const Divider(),
        //                 InfoRow(
        //                   icon: Icons.star,
        //                   label: 'Level',
        //                   value:
        //                       (level.isNotEmpty && level[0]['keterangan'] != null)
        //                           ? level[0]['keterangan'].toString()
        //                           : 'Tidak ada level',
        //                   onPressed: () {
        //                     showModalBottomSheet<void>(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return LevelModalBottomSheet(
        //                           title: 'Pilih Level',
        //                           items: level,
        //                         );
        //                       },
        //                     );
        //                   },
        //                 ),
        //                 const Divider(),
        //                 InfoRow(
        //                   icon: Icons.fastfood,
        //                   label: 'Toping',
        //                   value: (topping.isNotEmpty &&
        //                           topping[0]['keterangan'] != null)
        //                       ? topping[0]['keterangan'].toString()
        //                       : 'Tidak ada toping',
        //                   onPressed: () {
        //                     showModalBottomSheet<void>(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return ToppingModalBottomSheet(
        //                           title: 'Pilih Toping',
        //                           items: topping,
        //                         );
        //                       },
        //                     );
        //                   },
        //                 ),
        //                 const Divider(),
        //                 InfoRow(
        //                   icon: Icons.notes,
        //                   label: 'Catatan',
        //                   value: 'Tidak ada catatan',
        //                   onPressed: () {
        //                     showModalBottomSheet<void>(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return NotesModalBottomSheet(
        //                           title: 'Catatan',
        //                         );
        //                       },
        //                     );
        //                   },
        //                 ),
        //                 const Divider(),
        //                 const SizedBox(height: 20),
        //                 ElevatedButton(
        //                   style: ElevatedButton.styleFrom(
        //                     textStyle: const TextStyle(
        //                       fontSize: 20,
        //                       color: Colors.white,
        //                     ),
        //                     backgroundColor: ColorStyle.primary,
        //                     foregroundColor: Colors.white,
        //                     minimumSize: Size(double.infinity, 50.h),
        //                   ),
        //                   onPressed: () {
        //                     print(controller.quantity.value);
        //                   },
        //                   child: Text('Tambahkan Ke Pesanan'),
        //                 ),
        //               ],
        //             );
        //           }),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
