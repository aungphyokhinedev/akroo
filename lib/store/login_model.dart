import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/login_info.dart';
import 'package:essential/utils/custom_http.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @observable
  LoginInfo loginInfo = new LoginInfo();

  @action 
  Future<void> signOut()async{
    isLoggedIn = false;
    loginInfo = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loginInfo');
    prefs.remove('authorization');
  }

  @action
  Future<bool> checkLogin()async{
    try{
    final prefs = await SharedPreferences.getInstance();
    var _loginData = prefs.getString('loginInfo') ?? null;
    var _token = prefs.getString('authorization') ?? null;
    if(_loginData == null || _token == null){
      return false;
    }
    var parsedJson = json.decode(_loginData);
    loginInfo = LoginInfo.fromJson(parsedJson);
    CustomHttp.accessToken = _token;
    isLoggedIn = true;
    return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  @action
  Future<void> login(String token, String provider) async {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await getLogin(token, provider)
          .then((LoginInfo result) async{
          loginInfo = result;
          isLoggedIn = true;
          
         
          print('login success');
      });
    } finally {
      isLoading = false;
    }
  }

  
}


Future<LoginInfo> getLogin(String accessToken, String provider) async {
  final response =
      await http.post(Constants.baseUrl + '/login', body: {
    'token': accessToken,
    'provider': provider,
  });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var authorization = response.headers['authorization'];
    var parsedJson = json.decode(response.body);
    
    var loginInfo = LoginInfo.fromJson(parsedJson);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginInfo', response.body);
    await prefs.setString('authorization', authorization);
    //setting accesstoken to custom http
    CustomHttp.accessToken = authorization;
    return loginInfo;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to login');
  }
}
