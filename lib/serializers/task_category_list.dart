import 'package:essential/serializers/task_category.dart';

class TaskCategoryList{
  List<TaskCategory> topCategories = [];

  TaskCategoryList({this.topCategories});

  TaskCategoryList.fromJson(List<dynamic> newsList) {
    this.topCategories = [];
    for (var i = 0; i < newsList.length; i++) {
      this.topCategories.add(new TaskCategory.fromJson(newsList[i]));
    }
  }
}