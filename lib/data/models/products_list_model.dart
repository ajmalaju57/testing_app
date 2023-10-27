// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'products_list_model.g.dart';

ProductList productListFromJson(String str) =>
    ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  int? errorCode;
  List<Data>? data;
  String? message;

  ProductList({
    this.errorCode,
    this.data,
    this.message,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        errorCode: json["error_code"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? image;

  @HiveField(3)
  int? price;

  @HiveField(4)
  int? quantity;

  @HiveField(5)
  DateTime? createdDate;

  @HiveField(6)
  String? createdTime;

  @HiveField(7)
  DateTime? modifiedDate;

  @HiveField(8)
  String? modifiedTime;

  @HiveField(9)
  bool? flag;

  @HiveField(10)
  Uint8List? imageBytes;

  Data({  
    this.id,
    this.name,
    this.image,
    this.imageBytes,
    this.price,
    this.quantity,
    this.createdDate,
    this.createdTime,
    this.modifiedDate,
    this.modifiedTime,
    this.flag,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date":
            "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
      };
}
