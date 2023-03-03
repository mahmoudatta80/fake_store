class CardsModel {
  int? id;
  String? title;
  String? image;
  double? price;

  CardsModel(dynamic obj) {
    id = obj['id'];
    title = obj['title'];
    image = obj['image'];
    price = obj['price'];
  }

  CardsModel.fromJson(Map<String,dynamic> data) {
    id = data['id'];
    title = data['title'];
    image = data['image'];
    price = data['price'];
  }

  Map<String,dynamic> toMap()=> {'id':id,'title':title,'image':image,'price':price};
}