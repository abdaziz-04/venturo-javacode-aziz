import '../constants/checkout_api_constant.dart';

class CheckoutRepository {
  CheckoutRepository._();

  var apiConstant = CheckoutApiConstant();
  final List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    {
      'id_cart': 1,
      'qty': 1,
      'item': {
        "id_menu": 2,
        "name": "Chicken Slam ",
        "category": "food",
        "harga": 13000,
        "deskripsi":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.s",
        "foto": "https://i.ibb.co/R9kJtny/1637916829.png",
      },
    },
  ];

  List<Map<String, dynamic>> getListOfData() {
    return data;
  }
}
