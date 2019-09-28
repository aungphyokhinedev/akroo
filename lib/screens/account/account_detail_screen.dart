
import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'add_item_screen.dart';

class AccountDetailScreen extends StatefulWidget {
  final AccountCategory accountCategory;
  final ApplicationModel applicationModel;
  final Callback onDrawerPressed;
  AccountDetailScreen({
    @required this.accountCategory,
    @required this.applicationModel,
    @required this.onDrawerPressed,
  });

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailScreenState();
  }
}

class _AccountDetailScreenState extends State<AccountDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  ScrollController _scrollController;
  Color _color;

  //Tuple2<AccountTransactionList, Pagination> transactionList;
  //List<AccountTransaction> items;
  // Pagination pagination;
  String message = "";
  NumberFormat numberFormat =
      new NumberFormat.currency(name: '', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    _controller.forward();
    _color = ColorUtils.getColorFrom(id: widget.accountCategory.color);

    // widget.applicationModel.accountModel.setCategory(widget.taskCategory);
    //  DateFilter dateFilter = widget.applicationModel.commonModel.dateFilter;
    // if(dateFilter == null){
    //   dateFilter = DateFilter(Constants.timestampOptionMonth, DateTime.now());
    // }
    // widget.applicationModel.accountModel.setDateFilter(dateFilter);
    widget.applicationModel.accountModel.refresh();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.applicationModel.accountModel.next();

      setState(() {
        message = "reach the bottom";
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      //     widget.applicationModel.accountModel.first();
      setState(() {
        message = "reach the top";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: _color),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: new IconButton(
            padding: EdgeInsets.only(left: 0),
            icon: new Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black26),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          actions: [
            new IconButton(
              padding: EdgeInsets.only(right: 20),
              icon: new Icon(
                Icons.more,
              ),
              onPressed: () => widget.onDrawerPressed(),
            ),
          ],
        ),
        body: Observer(builder: (_) {
          var items = widget.applicationModel.accountModel.items;
          var pagination = widget.applicationModel.accountModel.pagination;

          return items.length == 0
              ? Center(
                  child: Column(
                  children: <Widget>[
                    Text('Currently no transaction.'),
                    Text('Press add to make new transaction.'),
                  ],
                ))
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 36.0, vertical: 0.0),
                          height: 100,
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
                                  'Total ${pagination.total} ${pagination.skip}',
                                  // "${model.getTotalTodosFrom(_task)} Task",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(color: Colors.grey[500]),
                                ),
                              ),
                              Container(
                                child: Text(widget.accountCategory.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(color: Colors.black54)),
                              ),
                              Spacer(),
                              // SparkGraph(expense: expense, income: income,)
                              //
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                //var todo = todoModel.todos[index];
                                //  final todo = todos[index];
                                _showSnackBar(String r) {
                                  print(r);
                                }

                                return new Slidable(
                                  delegate: new SlidableDrawerDelegate(),
                                  
                                  actionExtentRatio: 0.25,
                                  child: new Container(
                                    color: Colors.white,
                                    child: new ListTile(
                                  
                                      leading: new CircleAvatar(
                                        backgroundColor:  items[index].type ==
                                                          Constants
                                                              .transactionIncome
                                                      ? _color
                                                      : Colors.grey,
                                        child: new Text('${index+1}'),
                                        foregroundColor: Colors.white,
                                      ),
                                      title: new Text(numberFormat.format(
                                                    items[index].amount)),
                                      subtitle:
                                          new Text(items[index].title),
                                    ),
                                  ),
                                  actions: <Widget>[
                                
                                  ],
                                  secondaryActions: <Widget>[
                                 new IconSlideAction(
                                  caption: 'More',
                                  color: Colors.black45,
                                  icon: Icons.more_horiz,
                                  onTap: () => _showSnackBar('More'),
                                ),
                                    new IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        widget.applicationModel.accountModel
                                              .removeTransaction(
                                                  items[index].id)
                                              .then((onValue) {
                                            items.removeAt(index);
                                          });
                                      },
                                    ),
                                  ],
                                );

                                return Container(
                                    padding: EdgeInsets.only(
                                        left: 22.0, right: 22.0),
                                    child: ListTile(
                                      onTap: () async {
                                        //  todos[index].isDone = !todos[index].isDone;

                                        //model.updateTodo(todo.copy(
                                        //  isCompleted: todo.isCompleted == 1 ? 0 : 1))
                                      },
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 8.0),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete_outline),
                                        onPressed: () async {
                                          widget.applicationModel.accountModel
                                              .removeTransaction(
                                                  items[index].id)
                                              .then((onValue) {
                                            items.removeAt(index);
                                          });

                                          // model.removeTodo(todo)
                                        },
                                      ),
                                      title: Container(
                                          padding: EdgeInsets.only(
                                              left: 16.0, right: 22.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                numberFormat.format(
                                                    items[index].amount),
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: items[index].type ==
                                                          Constants
                                                              .transactionIncome
                                                      ? _color
                                                      : Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                items[index].title,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black54,
                                                  //fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ));
                              },
                              itemCount: items.length,
                            ),
                          ),
                        ),
                      ]),
                );
        }),

        //  DetailView(taskCategory: widget.taskCategory),
        //  todoData: widget.todoModel,

        floatingActionButton: FloatingActionButton(
          heroTag: 'fab_new_task',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTransactionScreen(
                  accountCategory: widget.accountCategory,
                  applicationModel: widget.applicationModel,
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
      child: Icon(Icons.more),
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
