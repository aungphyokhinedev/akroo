
import 'package:essential/serializers/calcuate_group.dart';
import 'package:essential/serializers/calculate_data.dart';
import 'package:essential/serializers/calculate_data_list.dart';
import 'package:essential/serializers/calculate_group_list.dart';
import 'package:essential/serializers/pagiantion.dart';
import 'package:essential/utils/constants.dart';
import 'package:essential/utils/custom_http.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';
import 'dart:convert';

import 'package:tuple/tuple.dart';

part 'calculate_model.g.dart';


class CalculateModel = CalculateModelBase with _$CalculateModel;

abstract class CalculateModelBase with Store {


  @observable
  Pagination pagination;



  @observable
  CalculateGroup currentGroup;

@observable
  ObservableList<CalculateGroup> grouplists = new ObservableList<CalculateGroup>();

  @observable
  ObservableList<CalculateData> items = new ObservableList<CalculateData>();

  @observable
  bool isLoading = false;

  @action
  void addItem(CalculateData item) {
    items.add(item);
  }

  @action
  void removeItem(int index) {
    items.removeAt(index);
  }

  @action
  void removeAll() {
    currentGroup = null;
    items.clear();
  }

  @action
  void updateItem(int index, CalculateData item) {
    items[index] = item;
  }

  @action
  void setCurrentGroup(CalculateGroup data) {
    currentGroup = data;
    items.clear();
    items.addAll(currentGroup.list);
  }



  @action
  Future<void> addCaculateGroup(CalculateGroup data) async {
    if(currentGroup == null){
      CalculateGroup result = await postCalculateData(data);
    currentGroup = result;
    items.clear();

    items.addAll(currentGroup.list);
    }
    else{
      data.id = currentGroup.id;
      CalculateGroup result = await patchCalculateGroupById(data);
    currentGroup = result;
    items.clear();

    items.addAll(currentGroup.list);
    }
  } 

  @action
  Future<void> deleteCaculateGroup(CalculateGroup data) async {
    await deleteCalculateGroup(data.id);
    grouplists.remove(data);
  } 

  @action
  refresh() {
    pagination = new Pagination(total: 10, limit: 10, skip: 0);
    grouplists.clear();
    loadCaculateGroups();
  }



  @action
  next() {
    if (pagination.hasNext()) {
      pagination.next();
      loadCaculateGroups();
    }
  }

  @action
  Future<void> loadCaculateGroups() async {
    try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
      await fetchTransactionList('',pagination)
          .then((Tuple2<CalculateGroupList, Pagination> result) {
        print('fetch length ${result.item1.items.length}');
        grouplists.addAll(result.item1.items);
        pagination = result.item2;
      });
    } finally {
      isLoading = false;
    }
  }

/*
  @action
   Future<void> getGroupList() async {
     try {
      print('try to fetch');
      if (isLoading) {
        return;
      }
      isLoading = true;
    await fetchCategoryList()
    .then((AccountCategoryList result) {
      categories  = new ObservableList<CalculateData>();
      result.topCategories.forEach((cat){
        categories.add(new CalculateData(
          cat,null
        ));
      });
       isLoading = false;
       print('fetch cat complete');
       
    });
    } finally {
      isLoading = false;
    }

  }
*/
  
}

Future<CalculateGroup> postCalculateData(CalculateGroup data) async {
  print('add calculate data');
  List<dynamic> _list = new List<dynamic>();
  data.list.forEach((item){
    _list.add(item.toJson());
  });
  final response = await CustomHttp.http.post(Constants.baseUrl + '/calculatedata',
  
  body: {
    'name':data.name,
    'time':data.time.millisecondsSinceEpoch.toString(),
    'list': jsonEncode(_list) 
  });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = CalculateGroup.fromJson(parsedJson);
   
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load calculate data');
  }
}

Future<Tuple2<CalculateGroupList, Pagination>> fetchTransactionList(
    String name, Pagination pagination) async {
  
  if(pagination == null ){
 throw Exception('Pagination data is required');
  }


  String url = Constants.baseUrl +
      '/calculatedata?' +
    //   name != '' ? 'name=' + name: '' +
      '\$skip=' +
      pagination.skip.toString() +
      '&\$limit=' +
      pagination.limit.toString() +
      '&\$sort[time]=-1';
  print('url ${url}');
  final response = await CustomHttp.http.get(url);

  print('response.statusCode ${response.statusCode}');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = CalculateGroupList.fromJson(parsedJson['data']);
    var pageinfo = Pagination.fromJson(parsedJson);
    return Tuple2<CalculateGroupList, Pagination>(result, pageinfo);
 
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}


Future<CalculateGroupList> deleteCalculateGroup(String id) async {
  final response =
      await CustomHttp.http.delete(Constants.baseUrl + '/calculatedata?_id=' + id);
  print('deleteTransaction ${id}');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = CalculateGroupList.fromJson(parsedJson);
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to delete todo');
  }
}


Future<CalculateGroup> patchCalculateGroupById(CalculateGroup data) async {
  print('fetchCategoryList');
  List<dynamic> _list = new List<dynamic>();
  data.list.forEach((item){
    _list.add(item.toJson());
  });
  final response = await CustomHttp.http.patch(Constants.baseUrl + '/calculatedata?_id=' + data.id,
  
  body: {
    'name':data.name,
    'time':data.time.millisecondsSinceEpoch.toString(),
    'list': jsonEncode(_list) 
  });

  
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = CalculateGroupList.fromJson(parsedJson);
   
    return result.items[0];
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load calculate data');
  }
}
