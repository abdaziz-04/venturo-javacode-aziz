import 'package:flutter/material.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class NotesModalBottomSheet extends StatelessWidget {
  final String title;

  final Function(dynamic)? onTap;

  const NotesModalBottomSheet({
    Key? key,
    required this.title,
    this.onTap,
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
                TextField(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check_circle, color: ColorStyle.primary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
