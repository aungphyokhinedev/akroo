import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/account_category_list.dart';
import 'package:essential/serializers/account_transaction.dart';
import 'package:essential/serializers/account_transation_list.dart';
import 'package:essential/serializers/date_filter.dart';
import 'package:essential/serializers/pagiantion.dart';
import 'package:essential/serializers/summary_info.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/utils/custom_http.dart';
import 'package:tuple/tuple.dart';

import '../utils/constants.dart';
import 'package:mobx/mobx.dart';


part 'account_model.g.dart';

class AccountModel = AccountModelBase with _$AccountModel;

abstract class AccountModelBase with Store {
  @observable
  AccountCategory accountCategory;

  

  @observable
  SummaryInfo summaryInfo;

 @observable
  int dateFilterDurationType;

  @observable
  DateFilter dateFilter;

  @observable
  ObservableFuture<Tuple2<AccountTransactionList, Pagination>> transactions;

  @observable
  ObservableList<AccountTransaction> items =
      ObservableList<AccountTransaction>();
  
  

  @observable
  bool isLoading = false;

  @observable
  Pagination pagination;
  @action
  setCategory(AccountCategory category) {
    accountCategory = category;
  }

  @action
  setDateFilter(DateFilter date) {
    print('account setDateFilter ${date.durationType}');
    dateFilter = date;
    dateFilterDurationType = date.durationType;
  }

  @action
  refresh() {
    pagination = new Pagination(total: 10, limit: 10, skip: 0);
    items.clear();
    loadTransactions(accountCategory.id);
  }



  @action
  next() {
    if (pagination.hasNext()) {
      pagination.next();
      loadTransactions(accountCategory.id);
    }
  }

  @action
  Future<void> loadTransactions(String catId) async {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await fetchTransactionList(catId, pagination, dateFilter)
          .then((Tuple2<AccountTransactionList, Pagination> result) {
        print('fetch length ${result.item1.items.length}');
        items.addAll(result.item1.items);
        pagination = result.item2;
      });
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> refreshCategoryId(String catId) async {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await setCategoryById(catId)
          .then((AccountCategoryList result) {
          accountCategory = result.topCategories.first;
      });
    } finally {
      isLoading = false;
    }
  }

   @action
  loadSummaryInfo() {
    fetchSummaryInfo(accountCategory.id,dateFilter).then((SummaryInfo result){
      summaryInfo = result;
      print('summary info ${result.income} ${result.expense}');
    });
  }

  @action
  Future<AccountTransaction> addTransaction(AccountTransaction transaction) {
    return postTransaction(transaction);
  }

  @action
  Future<AccountTransactionList> removeTransaction(String id) {
    return deleteTransaction(id);
  }
}

Future<Tuple2<AccountTransactionList, Pagination>> fetchTransactionList(
    String catId, Pagination pagination, DateFilter date) async {
  
  if(pagination == null ){
 throw Exception('Pagination data is required');
  }
  if(date == null) {
 throw Exception('Date filter data is required');
  }
  if(catId == null){
 throw Exception('Category filter data is required');
  }

  String url = Constants.baseUrl +
      '/transactions?cid=' +
      catId +
      '&\$skip=' +
      pagination.skip.toString() +
      '&\$limit=' +
      pagination.limit.toString() +
      '&\$sort[time]=-1';
  url += '&time[\$gt]=' + date.start.microsecondsSinceEpoch.toString();
  url += '&time[\$lt]=' + date.end.microsecondsSinceEpoch.toString();
  print('url ${url}');
  final response = await CustomHttp.http.get(url);

  print('response.statusCode ${response.statusCode}');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountTransactionList.fromJson(parsedJson['data']);
    var pageinfo = Pagination.fromJson(parsedJson);
    return Tuple2<AccountTransactionList, Pagination>(result, pageinfo);
 
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
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
    return result;
 
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}

Future<AccountTransaction> postTransaction(
    AccountTransaction transaction) async {
  final response = await CustomHttp.http.post(Constants.baseUrl + '/transactions', body: {
    'cid': transaction.cid,
    'title': transaction.title,
    'type': transaction.type.toString(),
    'amount': transaction.amount.toString(),
    'time': transaction.time.millisecondsSinceEpoch.toString()
  });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountTransaction.fromJson(parsedJson);
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to add todo');
  }
}

Future<AccountTransactionList> deleteTransaction(String id) async {
  final response =
      await CustomHttp.http.delete(Constants.baseUrl + '/transactions?_id=' + id);
  print('deleteTransaction ${id}');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = AccountTransactionList.fromJson(parsedJson);
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to delete todo');
  }
}

Future<AccountCategoryList> setCategoryById(String catId) async {
  print('fetchCategoryList');
  final response = await CustomHttp.http.get(Constants.baseUrl + '/taskcategories?_id=' + catId);

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
