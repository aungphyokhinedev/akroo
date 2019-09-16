import 'dart:async';
import 'dart:convert';
import 'package:essential/serializers/task_todo.dart';
import 'package:essential/serializers/task_todo_list.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:flutter/material.dart';

import '../serializers/task_category.dart';
import '../serializers/task_category_list.dart';
import '../utils/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'todo_model.g.dart';


class ToDoModel = ToDoModelBase with _$ToDoModel;

abstract class ToDoModelBase with Store {

  @observable
 ObservableFuture<List<TaskTodo>> todos;



  @action 
  updateTodo(TaskTodo todo){
    todos.then((onValue)=>onValue.where((t)=>t.id == todo.id).first.isDone = todo.isDone);
  }





  @action
  getTaskTodoList(String catId) {
    todos =  ObservableFuture(fetchTaskTodoList(catId)
    .then((TaskTodoList newsListObject) =>  newsListObject.todos));
  }

  @action
  addTaskTodo(TaskTodo todo) async {
   await postTaskTodo(todo).then((created){
     return created;
   });
  }

  @action
  updateTaskTodo(String id, dynamic body) async {
   await patchTaskTodo(id,body).then((updated){
     updateTodo(updated.todos.first);
     return updated;
   });
  }

  @action
  removeTaskTodo(String id) async {
   await deleteTaskTodo(id).then((deleted){
     return deleted;
   });
  }

  
}

Future<TaskCategoryList> fetchTaskCategoryList() async {
  final response = await http.get(Constants.baseUrl + '/taskcategories');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    print('News IDs List => ${parsedJson.toString()}');
    var result = TaskCategoryList.fromJson(parsedJson['data']);
    print('Result => ${result.topCategories.length}');
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}

Future<TaskCategory> postTaskCategory(TaskCategory category) async {
  print('addTaskCategory http ${category}');
  final response = await http.post(Constants.baseUrl + '/taskcategories',
      body: {'name':category.name,
        'logo': category.logo.toString(),
        'color': category.color.toString()
      });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = TaskCategory.fromJson(parsedJson);
    print('Result => ${result}');
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to add category');
  }
}


Future<TaskTodoList> fetchTaskTodoList(String catId) async {
  final response = await http.get(Constants.baseUrl + '/tasks?catId='+ catId);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    print('News IDs List => ${parsedJson.toString()}');
    var result = TaskTodoList.fromJson(parsedJson['data']);
    print('Result => ${result.todos}');
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load category');
  }
}

Future<TaskTodo> postTaskTodo(TaskTodo todo) async {
  final response = await http.post(Constants.baseUrl + '/tasks',
      body: {
        'catId':todo.catId,
        'name':todo.name,
        'isDone': todo.isDone.toString(),
        'time': todo.time.toIso8601String()
      });

  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = TaskTodo.fromJson(parsedJson);
    print('Result => ${result}');
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to add todo');
  }
}

Future<TaskTodoList> patchTaskTodo(String id, dynamic body ) async {
  final response = await http.patch(Constants.baseUrl + '/tasks?_id=' + id,
      body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = TaskTodoList.fromJson(parsedJson);
    print('Result => ${result}');
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to patch todo');
  }
}

Future<TaskTodoList> deleteTaskTodo(String id) async {
  final response = await http.delete(Constants.baseUrl + '/tasks?_id=' + id);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var parsedJson = json.decode(response.body);
    var result = TaskTodoList.fromJson(parsedJson);
    print('Result => ${result}');
    return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to delete todo');
  }
}
