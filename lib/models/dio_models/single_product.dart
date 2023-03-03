import 'package:store_app/models/dio_models/rating.dart';

class SingleProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  Rating? rating;

  SingleProductModel({this.id,this.title,this.price,this.description,this.image,this.rating});

  factory SingleProductModel.fromJson(Map<String,dynamic> json) {
    return SingleProductModel(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      image: json['image'],
      rating: (json['rating']!=null? Rating.fromJson(json['rating']):null),
    );
  }
}