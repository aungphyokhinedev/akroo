
import 'package:essential/serializers/price_group_data.dart';

class PriceGroupList{
  List<PriceGroupData> items = [];

  PriceGroupList({this.items});

  PriceGroupList.fromJson(List<dynamic> newsList) {
    this.items = [];
    for (var i = 0; i < newsList.length; i++) {
      this.items.add(new PriceGroupData.fromJson(newsList[i]));
    }
  }
}