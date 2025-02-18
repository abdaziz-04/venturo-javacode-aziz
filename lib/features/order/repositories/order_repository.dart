import '../constants/order_api_constant.dart';

class OrderRepository {
  OrderRepository();

  var apiConstant = OrderApiConstant();

  List<Map<String, dynamic>> ongoingOrder = [
    {
      "id_order": 35,
      "no_struk": "001/KWT/01/2022",
      "nama": "dev noersy",
      "total_bayar": 12000,
      "tanggal": "2023-06-19",
      "status": 0,
      "menu": [
        {
          "id_menu": 9,
          "kategori": "makanan",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/mRJnq3Z/nasi-goreng.jpg",
          "jumlah": 1,
          "harga": "10000",
          "total": 10000,
          "catatan": "test"
        }
      ]
    },
  ];

  // Get Ongoing Order
  List<Map<String, dynamic>> getOngoingOrder() {
    return ongoingOrder.where((element) => element['status'] < 3).toList();
  }

  // Get Order History
  List<Map<String, dynamic>> getOrderHistory() {
    return ongoingOrder.where((element) => element['status'] > 2).toList();
  }

  // Get Order Detail
  Map<String, dynamic>? getOrderDetail(int idOrder) {
    return ongoingOrder.firstWhere((element) => element['id_order'] == idOrder,
        orElse: () => {});
  }
}
