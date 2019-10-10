import 'package:essential/serializers/calculate_data_list.dart';
import 'dart:convert';
import 'calculate_data.dart';
import 'dart:async';

class CalculateGroup {
  String id;
  String name;
  DateTime time;
  List<CalculateData> list;

  CalculateGroup({
    this.id,
    this.name,
    this.time,
    this.list
    });
  factory CalculateGroup.fromJson(Map<String, dynamic> _json) {
  var _data = json.decode(_json['list'] as String);
  return CalculateGroup(
      id: _json['_id'] as String,
      name: _json['name'] as String,
      time:new DateTime.fromMillisecondsSinceEpoch(int.parse(_json['time'])) ,
      list: CalculateDataList.fromJson(_data).items
  );
  }
}