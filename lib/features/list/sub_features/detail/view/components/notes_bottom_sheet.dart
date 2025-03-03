import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/detail/controllers/list_detail_controller.dart';

import 'package:venturo_core/shared/styles/color_style.dart';

class NotesModalBottomSheet extends StatelessWidget {
  final String title;

  const NotesModalBottomSheet({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Container(
                width: 104,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: ListDetailController.to.notesController,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan catatan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      ListDetailController.to.addNotes();
                      Get.back();
                    },
                    icon: Icon(Icons.check_circle, color: ColorStyle.primary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
