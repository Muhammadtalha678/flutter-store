// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int id;
  String name;
  String title;
  String subTitle;
  String sku;
  int price;
  int discount;
  int quantity;
  int categoryId;
  int adminId;
  DateTime createdAt;
  DateTime updatedAt;
  String images;
  dynamic videos;
  String thumbnail;
  String categoryName;

  ProductModel({
    required this.id,
    required this.name,
    required this.title,
    required this.subTitle,
    required this.sku,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.categoryId,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.videos,
    required this.thumbnail,
    required this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        subTitle: json["subTitle"],
        sku: json["SKU"],
        price: json["price"],
        discount: json["discount"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        adminId: json["admin_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        images: json["images"],
        videos: json["videos"],
        thumbnail: json["thumbnail"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "subTitle": subTitle,
        "SKU": sku,
        "price": price,
        "discount": discount,
        "quantity": quantity,
        "category_id": categoryId,
        "admin_id": adminId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "images": images,
        "videos": videos,
        "thumbnail": thumbnail,
        "category_name": categoryName,
      };
}
