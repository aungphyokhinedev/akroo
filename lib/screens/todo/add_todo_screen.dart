import 'package:essential/model/hero_id_model.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/serializers/task_todo.dart';
import 'package:essential/store/todo_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class AddTodoScreen extends StatefulWidget {
  final TaskCategory taskCategory;
  final ToDoModel todoModel;

  AddTodoScreen({
     @required this.taskCategory,
    @required this.todoModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddTodoScreenState();
  }
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      newTask = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    

        
        var _color = ColorUtils.getColorFrom(id: widget.taskCategory.color);
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              widget.taskCategory.name,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What task are you planning to perfrom?',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() => newTask = text);
                  },
                  cursorColor: _color,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your Task...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(
                  height: 26.0,
                ),
                Row(
                  children: [
               
                    Container(
                      width: 16.0,
                    ),
                   
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_task',
                icon: Icon(Icons.add),
                backgroundColor: _color,
                label: Text('Create Task'),
                onPressed: () async{
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                          'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                      backgroundColor: _color,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                   await widget.todoModel.addTaskTodo(
                      new TaskTodo(name:newTask, isDone: false,time: DateTime.now(), catId: widget.taskCategory.id )
                    );

                    widget.todoModel.getTaskTodoList(widget.taskCategory.id);
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      
  }
}

// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
