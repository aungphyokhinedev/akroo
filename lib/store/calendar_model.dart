import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/calendar_data.dart';
import 'package:essential/utils/custom_http.dart';
import '../utils/constants.dart';
import 'package:mobx/mobx.dart';


part 'calendar_model.g.dart';


class CalendarModel = CalendarModelBase with _$CalendarModel;

abstract class CalendarModelBase with Store {

  @observable
  CalendarData mmData;

  @observable
  bool isLoading = false;

  @action
  Future<void> getData(DateTime date) async  {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await fetchData(date)
          .then((CalendarData data) {
        mmData = data;

      });
    } finally {
      isLoading = false;
    }

  }

  
}



Future<CalendarData> fetchData(DateTime date) async {
  print('fetch calendar');
  String url = Constants.baseUrl + '/myanmarcalendar?';
  url += '&year=' + date.year.toString();
  url += '&month=' + date.month.toString();
  url += '&day=' + date.day.toString();

  final response = await CustomHttp.http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var data = json.decode(response.body);
    var result = CalendarData.fromJson(data);
   
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}

