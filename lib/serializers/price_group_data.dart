
import 'package:essential/serializers/price_data.dart';
import 'package:essential/serializers/price_data_list.dart';

class PriceGroupData {

  String name;
  List<PriceData> values;
  String unit;


  PriceGroupData({
    this.name,
    this.values,
    this.unit,
    });
  factory PriceGroupData.fromJson(Map<String, dynamic> json) {
  return PriceGroupData(
      name: json['name'] as String,
      values: PriceDataList.fromJson(json['values']).items,
      unit: json['unit'] as String,
  );
}

}