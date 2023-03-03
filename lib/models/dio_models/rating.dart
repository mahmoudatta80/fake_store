class Rating {
  double? rate;
  int? count;

  Rating({this.rate,this.count});

  factory Rating.fromJson(Map<String,dynamic> json) {
    return Rating(
      rate: double.parse(json['rate'].toString()),
      count: json['count'],
    );
  }
}