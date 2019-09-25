
class PriceData {

  String name;
  double rate;
  String type1;
  String type2;
  double rate1;
  double rate2;
  String date;

  PriceData({
    this.name,
    this.rate,
    this.type1, 
    this.type2, 
    this.rate1, 
    this.rate2,
    this.date,
    });
  factory PriceData.fromJson(Map<String, dynamic> json) {
  return PriceData(
      name: json['name'] as String,
      rate: double.parse(json['rate'] != null ?json['rate'].toString():'0.0'),
      type1: json['type1'] as String,
      type2: json['type2'] as String,
      rate1: double.parse(json['rate1'] != null ?json['rate1'].toString():'0.0'),
      rate2: double.parse(json['rate2'] != null ?json['rate2'].toString():'0.0'),
      date: json['date'] as String,
  );
}

}