
import 'package:essential/serializers/price_data.dart';

class PriceDataList{
  List<PriceData> items = [];

  PriceDataList({this.items});

  PriceDataList.fromJson(List<dynamic> newsList) {
    this.items = [];
    for (var i = 0; i < newsList.length; i++) {
      this.items.add(new PriceData.fromJson(newsList[i]));
    }
  }
}