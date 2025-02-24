import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/repositories/voucher_repository.dart';

class CheckoutVoucherController extends GetxController {
  static CheckoutVoucherController get to => Get.find();
  late VoucherRepository voucherRepository;
  final RxList<Map<String, dynamic>> voucher = <Map<String, dynamic>>[].obs;
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
    print("🪳 Data voucher di controller: ${voucher}");
  }

  void addVoucher(Map<String, dynamic> item) {
    print("🎫 Voucher yang dipilih: ${selectedVoucher}");
    if (selectedVoucher.contains(item)) {
      selectedVoucher.remove(item);
      print("🎫 Voucher ${item['nominal']} dihapus");
    } else {
      selectedVoucher.add(item);
      print("🎫 Voucher ${item['nominal']} ditambahkan");
    }
  }

  void confirmVoucher() {
    print("🎫 Voucher yang dipilih: ${selectedVoucher}");
    final totalNominal = selectedVoucher.fold<int>(0, (prev, element) {
      return prev + (element['nominal'] as int? ?? 0);
    });
    CheckoutController.to.addVoucher(totalNominal);
  }
}
