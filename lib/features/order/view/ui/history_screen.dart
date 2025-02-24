import 'package:flutter/material.dart';
import 'package:venturo_core/features/order/view/components/no_data.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NoData(
          info:
              'Mulai buat Pesanan. Makanan yang kamu pesan akan muncul di sini agar kamu bisa menemukan menu favoritmu lagi'),
    );
  }
}
