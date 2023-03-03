import 'package:store_app/models/dio_models/rating.dart';

class CategoriesModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  Rating? rating;

  CategoriesModel({this.id,this.title,this.price,this.description,this.image,this.rating});

  factory CategoriesModel.fromJson(Map<String,dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      image: json['image'],
      rating: (json['rating']!=null? Rating.fromJson(json['rating']):null),
    );
  }
}