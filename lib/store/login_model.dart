import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/login_info.dart';
import 'package:essential/utils/custom_http.dart';
import 'package:tuple/tuple.dart';

import '../utils/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'login_model.g.dart';

class LoginModel = LoginModelBase with _$LoginModel;

abstract class LoginModelBase with Store {

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;


  String accessToken;

  @observable
  LoginInfo loginInfo = new LoginInfo();


  @action
  Future<void> login(String token, String provider) async {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await getLogin(token, provider)
          .then((Tuple2<LoginInfo,String> result) {
          loginInfo = result.item1;
          accessToken = result.item2;
          isLoggedIn = true;
         
      });
    } finally {
      isLoading = false;
    }
  }

  
}


Future<Tuple2<LoginInfo,String>> getLogin(String accessToken, String provider) async {
  final response =
      await http.post(Constants.baseUrl + '/login', body: {
    'token': accessToken,
    'provider': provider,
  });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var authorization = response.headers['authorization'];
    var parsedJson = json.decode(response.body);
    var result = LoginInfo.fromJson(parsedJson);

    //setting accesstoken to custom http
    CustomHttp.accessToken = authorization;
    return Tuple2(result,authorization);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to login');
  }
}
