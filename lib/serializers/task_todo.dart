
class TaskTodo {
  String id;
  String name;
  bool isDone;
  DateTime time;
  String catId;

  TaskTodo({this.id,this.name,this.isDone, this.time, this.catId});
  factory TaskTodo.fromJson(Map<String, dynamic> json) {
  return TaskTodo(
      id: json['_id'] as String,
      name: json['name'] as String,
      isDone: json['isDone'].toLowerCase() == 'true',
      time: DateTime.parse(json['time']),
      catId: json['catId'] as String,
  );
}


  

  
}