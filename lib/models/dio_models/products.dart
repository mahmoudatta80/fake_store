import 'package:store_app/models/dio_models/rating.dart';

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  Rating? rating;

  ProductModel({this.id,this.title,this.price,this.description,this.image,this.rating});

  factory ProductModel.fromJson(Map<String,dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      image: json['image'],
      rating: (json['rating']!=null? Rating.fromJson(json['rating']):null),
    );
  }
}




// "id": 1,
// "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
// "price": 109.95,
// "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
// "category": "men's clothing",
// "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
// "rating": {
// "rate": 3.9,
// "count": 120
// }