// To parse this JSON data, do
//
//     final banners = bannersFromJson(jsonString);

import 'dart:convert';

List<Banners> bannersFromJson(String str) =>
    List<Banners>.from(json.decode(str).map((x) => Banners.fromJson(x)));

String bannersToJson(List<Banners> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banners {
  int id;
  String sliderImages;
  String bannerImage;
  DateTime createdAt;
  DateTime updatedAt;

  Banners({
    required this.id,
    required this.sliderImages,
    required this.bannerImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        id: json["id"],
        sliderImages: json["slider_images"],
        bannerImage: json["banner_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slider_images": sliderImages,
        "banner_image": bannerImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
