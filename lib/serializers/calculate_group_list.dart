
import 'calcuate_group.dart';

class CalculateGroupList{
  List<CalculateGroup> items = [];

  CalculateGroupList({this.items});

  CalculateGroupList.fromJson(List<dynamic> newsList) {
    this.items = [];
    for (var i = 0; i < newsList.length; i++) {
      this.items.add(new CalculateGroup.fromJson(newsList[i]));
    }
  }
}