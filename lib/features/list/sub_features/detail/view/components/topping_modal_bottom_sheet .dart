import 'package:flutter/material.dart';

import 'option_chip.dart';

// s
class ToppingModalBottomSheet extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final Function(dynamic)? onTap;

  const ToppingModalBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OptionChip(
                    text: item['keterangan'] ?? 'Tidak ada keterangan',
                    isSelected: false,
                    onTap: () {
                      // controller.selectedToppings.value = item;
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
