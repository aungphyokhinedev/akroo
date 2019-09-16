
import 'package:essential/serializers/task_todo.dart';

class TaskTodoList{
  List<TaskTodo> todos = [];

  TaskTodoList({this.todos});

  TaskTodoList.fromJson(List<dynamic> newsList) {
    this.todos = [];
    for (var i = 0; i < newsList.length; i++) {
      this.todos.add(new TaskTodo.fromJson(newsList[i]));
    }
  }
}