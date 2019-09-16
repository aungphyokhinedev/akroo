
import 'package:essential/serializers/task_category.dart';
import 'package:essential/serializers/task_todo.dart';
import 'package:essential/serializers/task_todo_list.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/store/todo_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:essential/widgets/task_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'add_todo_screen.dart';

class DetailScreen extends StatefulWidget {
  final TaskCategory taskCategory;
  final ApplicationModel applicationModel;
  DetailScreen({
     @required this.taskCategory,
    @required this.applicationModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  Color _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    _controller.forward();
    _color = ColorUtils.getColorFrom(id: widget.taskCategory.color);

    
  }

  List<TaskTodo> todos;
  @override
  Widget build(BuildContext context) {
    widget.applicationModel.toDoModel.getTaskTodoList(widget.taskCategory.id);
    return Theme(
      data: ThemeData(primarySwatch: _color),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black26),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: [
            SimpleAlertDialog(
                color: _color,
                onActionPressed: () {
                  //model.removeTask(_task),
                }),
          ],
        ),
        body: Observer(builder: (_) {
          if (widget.applicationModel.toDoModel.todos.status == FutureStatus.pending) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (widget.applicationModel.toDoModel.todos.status == FutureStatus.fulfilled) {
            todos = widget.applicationModel.toDoModel.todos.result;

            //  List<TaskTodo> todos = widget.todoModel.todos.result;
            final doneCount = todos.where((t) => t.isDone).length;
            var doneProgress =
                todos.length > 0 ? (doneCount / todos.length) * 100 : 0;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
                      height: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //  TodoBadge(
                          //    color: _color,
                          //   codePoint: widget.taskCategory.logo,
                          //   id: widget.taskCategory.id,
                          // ),
                          Spacer(
                            flex: 1,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              'tasks ${todos.length}',
                              // "${model.getTotalTodosFrom(_task)} Task",
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(color: Colors.grey[500]),
                            ),
                          ),
                          Container(
                            child: Text(widget.taskCategory.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: Colors.black54)),
                          ),
                          Spacer(),
                          TaskProgressIndicator(
                            color: _color,
                            progress: doneProgress.round(),
                          ),
                          //
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            //var todo = todoModel.todos[index];
                            //  final todo = todos[index];
                            return Container(
                              padding: EdgeInsets.only(left: 22.0, right: 22.0),
                              child: ListTile(
                                onTap: () async {
                                  //  todos[index].isDone = !todos[index].isDone;
                                  await widget.applicationModel.toDoModel.updateTaskTodo(
                                      todos[index].id, {
                                    'isDone': (!todos[index].isDone).toString()
                                  });
                                  //model.updateTodo(todo.copy(
                                  //  isCompleted: todo.isCompleted == 1 ? 0 : 1))
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8.0),
                                leading: Checkbox(
                                    onChanged: (value) {
                                      ///  model.updateTodo(
                                      // todo.copy(isCompleted: value ? 1 : 0))
                                    },
                                    value: todos[index].isDone),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete_outline),
                                  onPressed: () {
                                    // model.removeTodo(todo)
                                  },
                                ),
                                title: Text(
                                  todos[index].name,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: todos[index].isDone
                                        ? _color
                                        : Colors.black54,
                                    decoration: todos[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: todos.length,
                        ),
                      ),
                    ),
                  ]),
            );
          } else {
            return Center(
              child: Text('Error'),
            );
          }
        }),

        //  DetailView(taskCategory: widget.taskCategory),
        //  todoData: widget.todoModel,

        floatingActionButton: FloatingActionButton(
          heroTag: 'fab_new_task',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodoScreen(
                  taskCategory: widget.taskCategory,
                  todoModel: widget.applicationModel.toDoModel,
                ),
              ),
            );
          },
          tooltip: 'New Todo',
          backgroundColor: _color,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DetailView extends StatelessWidget {
  Color _color;

  final TaskCategory taskCategory;

  DetailView({
    @required this.taskCategory,
  });
  List<TaskTodo> todos = new List<TaskTodo>();
  @override
  Widget build(BuildContext context) {
    final todoModel = InheritedDataProvider.of(context).applicationModel.toDoModel;
    _color = ColorUtils.getColorFrom(id: taskCategory.color);
    // todoModel.getTaskTodoList(taskCategory.id);
    //var _todos = todoModel.todos;
    return Observer(builder: (_) {
      if (todoModel.todos.status == FutureStatus.pending) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (todoModel.todos.status == FutureStatus.fulfilled) {
        todos = todoModel.todos.result;
        final doneCount = todos.where((t) => t.isDone).length;
        var doneProgress =
            todos.length > 0 ? (doneCount / todos.length) * 100 : 0;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //  TodoBadge(
                  //    color: _color,
                  //   codePoint: widget.taskCategory.logo,
                  //   id: widget.taskCategory.id,
                  // ),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'tasks ${todos.length}',
                      // "${model.getTotalTodosFrom(_task)} Task",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.grey[500]),
                    ),
                  ),
                  Container(
                    child: Text(taskCategory.name,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black54)),
                  ),
                  Spacer(),
                  TaskProgressIndicator(
                    color: _color,
                    progress: doneProgress.round(),
                  ),
                  //
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    //var todo = todoModel.todos[index];
                    //  final todo = todos[index];
                    return Container(
                      padding: EdgeInsets.only(left: 22.0, right: 22.0),
                      child: ListTile(
                        onTap: () async {
                          //  todos[index].isDone = !todos[index].isDone;
                          await todoModel.updateTaskTodo(todos[index].id,
                              {'isDone': (!todos[index].isDone).toString()});

                          //model.updateTodo(todo.copy(
                          //  isCompleted: todo.isCompleted == 1 ? 0 : 1))
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                        leading: Checkbox(
                            onChanged: (value) {
                              ///  model.updateTodo(
                              // todo.copy(isCompleted: value ? 1 : 0))
                            },
                            value: todos[index].isDone),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            // model.removeTodo(todo)
                          },
                        ),
                        title: Text(
                          todos[index].name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color:
                                todos[index].isDone ? _color : Colors.black54,
                            decoration: todos[index].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: todos.length,
                ),
              ),
            ),
          ]),
        );
      } else {
        return Center(
          child: Text('Error'),
        );
      }
    });
  }
}

typedef void Callback();

class SimpleAlertDialog extends StatelessWidget {
  final Color color;
  final Callback onActionPressed;

  SimpleAlertDialog({
    @required this.color,
    @required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: color,
      child: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete this card?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'This is a one way street! Deleting this will remove all the task assigned in this card.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    onActionPressed();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  textColor: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
