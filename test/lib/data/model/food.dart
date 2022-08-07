// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  Food({
    this.data,
  });

  List<Datum> data;
  void addProduct(Datum p) {
    data.add(p);
  }

  void removeProduct(Datum p) {
    data.add(p);
  }

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
      
}

class Datum {
  Datum({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.price,
    this.featuredImage,
    this.status,
    this.createdAt,
    this.quantity = 1,
  });

  int id;
  String slug;
  String title;
  String description;
  int price;
  String featuredImage;
  String status;
  DateTime createdAt;
  int quantity;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        slug: json["slug"] == null ? null : json["slug"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"],
        featuredImage:
            json["featured_image"] == null ? null : json["featured_image"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        quantity: 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "slug": slug == null ? null : slug,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "featured_image": featuredImage == null ? null : featuredImage,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "quantity": quantity == null ? null : quantity,
      };
}
