

import 'calculate_data.dart';

class CalculateDataList{
  List<CalculateData> items = [];

  CalculateDataList({this.items});

  CalculateDataList.fromJson(List<dynamic> newsList) {
    this.items = [];
    for (var i = 0; i < newsList.length; i++) {
      this.items.add(new CalculateData.fromJson(newsList[i]));
    }
  }


}