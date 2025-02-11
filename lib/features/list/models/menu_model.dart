import 'dart:convert';

class MenuModel {
  int statusCode;
  List<Datum> data;

  MenuModel({
    required this.statusCode,
    required this.data,
  });

  factory MenuModel.fromRawJson(String str) =>
      MenuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        statusCode: json["status_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int idMenu;
  String nama;
  Kategori kategori;
  int harga;
  String deskripsi;
  String? foto;
  int status;

  Datum({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idMenu: json["id_menu"],
        nama: json["nama"],
        kategori: kategoriValues.map[json["kategori"]]!,
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        foto: json["foto"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "nama": nama,
        "kategori": kategoriValues.reverse[kategori],
        "harga": harga,
        "deskripsi": deskripsi,
        "foto": foto,
        "status": status,
      };
}

enum Kategori { MAKANAN, MINUMAN, SNACK }

final kategoriValues = EnumValues({
  "makanan": Kategori.MAKANAN,
  "minuman": Kategori.MINUMAN,
  "snack": Kategori.SNACK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
