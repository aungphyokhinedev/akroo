import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/calendar_data.dart';
import 'package:essential/serializers/pirce_group_list.dart';
import 'package:essential/utils/custom_http.dart';
import '../utils/constants.dart';
import 'package:mobx/mobx.dart';


part 'price_list_model.g.dart';


class PriceListModel = PriceListModelBase with _$PriceListModel;

abstract class PriceListModelBase with Store {

  @observable
  PriceGroupList mmData;

  @observable
  bool isLoading = false;

  @action
  Future<void> getData() async  {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await fetchData()
          .then((PriceGroupList data) {
        mmData = data;

      });
    } finally {
      isLoading = false;
    }

  }

  
}



Future<PriceGroupList> fetchData() async {
  print('fetch calendar');
  String url = Constants.baseUrl + '/data/mk_prices.json';

  final response = await CustomHttp.http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var data = json.decode(response.body);
    var result = PriceGroupList.fromJson(data['data']);
   
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}

