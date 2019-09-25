import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/account_category_list.dart';
import 'package:essential/serializers/date_filter.dart';
import 'package:essential/serializers/summary_info.dart';
import 'package:essential/utils/custom_http.dart';
import 'package:http/http.dart';

import '../utils/constants.dart';
import 'package:mobx/mobx.dart';


part 'account_category_model.g.dart';


class AccountCategoryModel = AccountCategoryModelBase with _$AccountCategoryModel;

abstract class AccountCategoryModelBase with Store {

  @observable
  ObservableList<AccountCategory> categories;

  @observable
  bool isLoading = false;

  @observable
  SummaryInfo summaryInfo;

  @action
   Future<void> getCategoryList() async {
     try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
    await fetchCategoryList()
    .then((AccountCategoryList result) {
      categories  = new ObservableList<AccountCategory>();
       categories.addAll(result.topCategories);
       isLoading = false;
       print('fetch cat complete');
       
    });
    } finally {
      isLoading = false;
    }

  }

  @action
  addCategory(AccountCategory newcategory) async{
     try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      await postCategory(newcategory).then((category) {
         isLoading = false;
      });
    } finally {
      isLoading = false;
    }
  }

  @action
  updateCategory(AccountCategory updateCategory) async{
   await patchCategory(updateCategory).then((category) {
   });
  }



   @action
  loadSummaryInfo(String catId,DateFilter dateFilter) {
    if(catId != null){
      fetchSummaryInfo(catId,dateFilter).then((SummaryInfo result){
       summaryInfo = result;
   
    });
    }
    
  }

  @action
  removeCategory(String id) async {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      await deleteCategory(id).then((deleted){
         isLoading = false;
        return deleted;
      });
    } finally {
      isLoading = false;
    }
   
  }

   @action
   refreshCategory(AccountCategory updatedValue) {
     categories.forEach((item){
       if(item.id == updatedValue.id){
         item.name = updatedValue.name;
         item.color = updatedValue.color;
         item.logo = updatedValue.logo;
         item.dailyLimit =updatedValue.dailyLimit;
         item.monthlyLimit =updatedValue.monthlyLimit;
         
       }
     });
  }
}

Future<SummaryInfo> fetchSummaryInfo(
    String catId, DateFilter date) async {

  if(date == null) {
 throw Exception('Date filter data is required');
  }
  if(catId == null){
 throw Exception('Category filter data is required');
  }

  String url = Constants.baseUrl +
      '/summary?cid=' +
      catId;
  url += '&time[\$gt]=' + date.start.millisecondsSinceEpoch.toString();
  url += '&time[\$lt]=' + date.end.millisecondsSinceEpoch.toString();
  print('url ${url}');
  final response = await CustomHttp.http.get(url);

  print('response.statusCode ${response.statusCode}');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = SummaryInfo.fromJson(parsedJson);
    result.catId = catId;
    return result;
 
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load summary');
  }
}


Future<AccountCategoryList> fetchCategoryList() async {
  print('fetchCategoryList');
  final response = await CustomHttp.http.get(Constants.baseUrl + '/taskcategories');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountCategoryList.fromJson(parsedJson['data']);
   
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}

Future<AccountCategory> postCategory(AccountCategory category) async {
  final response = await CustomHttp.http.post(Constants.baseUrl + '/taskcategories',
      body: {'name':category.name,
        'logo': category.logo.toString(),
        'color': category.color.toString()
      });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountCategory.fromJson(parsedJson);
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to add category');
  }
}


Future<AccountCategoryList> deleteCategory(String id) async {
  final response = await CustomHttp.http.delete(Constants.baseUrl + '/taskcategories?_id=' + id,);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountCategoryList.fromJson(parsedJson);
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to add category');
  }
}

Future<AccountCategoryList> patchCategory(AccountCategory category) async {
  Map<String,String> _body = new Map<String,String>();
  if(category.name != null){
    _body.addAll({'name':category.name});
  }
  if(category.logo != null){
    _body.addAll({'logo':category.logo.toString()});
  }
  if(category.color != null){
    _body.addAll({'color':category.color.toString()});
  }
  if(category.dailyLimit != null){
    _body.addAll({'daily_limit':category.dailyLimit.toString()});
  }
  if(category.monthlyLimit != null){
    _body.addAll({'monthly_limit':category.monthlyLimit.toString()});
  }

  
  final response = await CustomHttp.http.patch(Constants.baseUrl + '/taskcategories?_id=' + category.id,
      body: _body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountCategoryList.fromJson(parsedJson);
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to update category');
  }
}