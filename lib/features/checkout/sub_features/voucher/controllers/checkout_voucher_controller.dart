import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/repositories/voucher_repository.dart';

class CheckoutVoucherController extends GetxController {
  static CheckoutVoucherController get to => Get.find();
  late VoucherRepository voucherRepository;

  // Data voucher dari API
  final RxList<Map<String, dynamic>> voucher = <Map<String, dynamic>>[].obs;

  // Hanya menyimpan satu voucher yang dipilih, agar dapat diakses dengan index 0
  final RxList<Map<String, dynamic>> selectedVoucher =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    voucherRepository = VoucherRepository();
    getAllVoucher();
  }

  Future<void> getAllVoucher() async {
    print("📦 Mengambil data voucher dari API...");
    final result = await voucherRepository.fetchAllVoucher();

    print("Tipe data result['data']: ${result['data'].runtimeType}");
    print("Isi result['data']: ${result['data']}");

    voucher.addAll(result['data']);
    print("🪳 Data voucher di controller: $voucher");
  }

  // Logika single selection: hanya satu voucher yang disimpan dalam list
  void addVoucher(Map<String, dynamic> item) {
    if (selectedVoucher.contains(item)) {
      // Jika sudah terpilih, hapus voucher tersebut
      selectedVoucher.remove(item);
      print("🎫 Voucher ${item['nominal']} dihapus");
    } else {
      // Clear list sebelum menambah voucher baru
      selectedVoucher.clear();
      selectedVoucher.add(item);
      print("🎫 Voucher ${item['nominal']} ditambahkan");
    }
  }

  void confirmVoucher() {
    if (selectedVoucher.isNotEmpty) {
      // Mengakses voucher yang terpilih menggunakan index 0
      final selected = selectedVoucher[0];
      final totalNominal = selected['nominal'] as int? ?? 0;
      print("🎫 Voucher yang dikonfirmasi: $selected");
      CheckoutController.to.addVoucher(totalNominal);
    } else {
      print("🎫 Tidak ada voucher yang terpilih");
    }
  }
}
