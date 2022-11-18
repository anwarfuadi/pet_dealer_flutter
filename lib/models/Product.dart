import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  String description;
  int price;
  bool isReady;
  bool isNew;
  bool isPopular;
  int category_id;
  List<String> images;

  Product(
    this.id,
    this.name,
    this.description,
    this.price,
    this.isReady,
    this.isNew,
    this.isPopular,
    this.category_id,
    this.images,
  );

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      json['id'],
      json['name'].toString(),
      json['description'].toString(),
      json['price'],
      json['isReady'] == 0 ? false : true,
      json['isNew'] == 0 ? false : true,
      json['isPopular'] == 0 ? false : true,
      json['category_id'],
      (json['images'] as List).map((item) => item["image_path"] as String).toList()
    );  
  }
}

// Our demo Products

List<Product> demoProducts = [
  // Product(
  //   id: 1,
  //   images: [
  //     "assets/images/ps4_console_white_1.png",
  //     "assets/images/ps4_console_white_2.png",
  //     "assets/images/ps4_console_white_3.png",
  //     "assets/images/ps4_console_white_4.png",
  //   ],
  //   colors: [
  //     Color(0xFFF6625E),
  //     Color(0xFF836DB8),
  //     Color(0xFFDECB9C),
  //     Colors.white,
  //   ],
  //   title: "Wireless Controller for PS4™",
  //   price: 64.99,
  //   description: description,
  //   rating: 4.8,
  //   isFavourite: true,
  //   isPopular: true,
  // ),
  // Product(
  //   id: 2,
  //   images: [
  //     "assets/images/Image Popular Product 2.png",
  //   ],
  //   colors: [
  //     Color(0xFFF6625E),
  //     Color(0xFF836DB8),
  //     Color(0xFFDECB9C),
  //     Colors.white,
  //   ],
  //   title: "Nike Sport White - Man Pant",
  //   price: 50.5,
  //   description: description,
  //   rating: 4.1,
  //   isPopular: true,
  // ),
  // Product(
  //   id: 3,
  //   images: [
  //     "assets/images/glap.png",
  //   ],
  //   colors: [
  //     Color(0xFFF6625E),
  //     Color(0xFF836DB8),
  //     Color(0xFFDECB9C),
  //     Colors.white,
  //   ],
  //   title: "Gloves XC Omega - Polygon",
  //   price: 36.55,
  //   description: description,
  //   rating: 4.1,
  //   isFavourite: true,
  //   isPopular: true,
  // ),
  // Product(
  //   id: 4,
  //   images: [
  //     "assets/images/wireless headset.png",
  //   ],
  //   colors: [
  //     Color(0xFFF6625E),
  //     Color(0xFF836DB8),
  //     Color(0xFFDECB9C),
  //     Colors.white,
  //   ],
  //   title: "Logitech Head",
  //   price: 20.20,
  //   description: description,
  //   rating: 4.1,
  //   isFavourite: true,
  // ),
];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
