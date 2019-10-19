import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/store/card_model.dart';
import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/common/number_color_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:flutter/services.dart';
import 'add_item_screen.dart';

class AccountDetailScreen extends StatefulWidget {
  final CardModel category;
  final ApplicationModel applicationModel;
  final Callback onDrawerPressed;
  AccountDetailScreen({
    @required this.category,
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
  CurvedAnimation _animation;
  ScrollController _scrollController;
  Color _color;

  //Tuple2<AccountTransactionList, Pagination> transactionList;
  //List<AccountTransaction> items;
  // Pagination pagination;
  String message = "";
  NumberFormat numberFormat =
      new NumberFormat.currency(name: '', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    print('init card detail screen');
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _color = ColorUtils.getColorFrom(id: widget.category.accountCategory.color);

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

  bool _visible = true;
  String _selectedId;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
          // backgroundColor:_color,
          appBar: AppBar(
            leading: new IconButton(
              padding: EdgeInsets.only(left: 0),
              icon: new Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            iconTheme: CustomTheme.of(context).iconTheme,
            brightness: CustomTheme.of(context).brightness,
            backgroundColor: Colors.transparent,
            actions: [
              new IconButton(
                padding: EdgeInsets.only(right: 20),
                icon: new Icon(
                  Icons.filter_list,
                ),
                onPressed: () {
                  widget.onDrawerPressed();
                },
              ),
            ],
          ),
          body: Observer(builder: (_) {
            var items = widget.applicationModel.accountModel.items;
            var pagination = widget.applicationModel.accountModel.pagination;
            var moment = new Moment.now();
            var _mf = new DateFormat('dd/MM/yy');
            var _df = new DateFormat('HH:mm');
            var _load = widget.applicationModel.accountModel.isLoading;
            return items.length == 0
                ? Center(
                    child: Column(
                    children: _load
                        ? <Widget>[Text('Loading transaction.')]
                        : <Widget>[
                            Text('Currently no transaction.'),
                            Text('Press button to add new transaction.'),
                          ],
                  ))
                : Padding(
                    padding: EdgeInsets.symmetric(
                        //   horizontal: SizeConfig.blockSizeVertical * 1.5,
                        vertical: 8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeVertical * 3,
                                vertical: 0.0),
                            height: 70,
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
                                    'Total ${pagination.total}',
                                    // "${model.getTotalTodosFrom(_task)} Task",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      widget.category.accountCategory.name,
                                      style: Theme.of(context).textTheme.title.copyWith(
                                                      fontSize: SizeConfig.blockSizeVertical * 2.3
                                                    )),
                                ),
                                Spacer(),
                                // SparkGraph(expense: expense, income: income,)
                                //
                              ],
                            ),
                          ),
                          _load
                              ? Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 3),
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 8),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.blockSizeVertical *
                                                    3,
                                            vertical:
                                                SizeConfig.blockSizeVertical *
                                                    2),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedId = items[index].id;
                                                print(_selectedId);
                                              });
                                            },
                                            child: Container(
                                              child: Container(
                                                  child: Column(
                                                children: <Widget>[
                                                  Row(
                                                      // mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            NumberColorText(value:items[index].amount ,type: items[index].type,),
                                                            Text(
                                                                items[index]
                                                                    .title,
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .body1),
                                                          ],
                                                        ),
                                                      ]),
                                                  items[index].id == _selectedId
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: SizeConfig
                                                                    .blockSizeVertical *
                                                                0,
                                                            //  horizontal: SizeConfig.blockSizeVertical * 2
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                  _mf.format(items[
                                                                              index]
                                                                          .time) +
                                                                      ' ' +
                                                                      _df.format(
                                                                          items[index]
                                                                              .time),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .body1),
                                                              Text(
                                                                  moment.from(
                                                                      items[index]
                                                                          .time),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .body1)
                                                            ],
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              )),
                                            ))),
                                    actions: <Widget>[],
                                    secondaryActions: <Widget>[
                                      new IconSlideAction(
                                        caption: 'Copy',
                                        color: Colors.black12,
                                        icon: Icons.more_horiz,
                                        onTap: () {
                                          Clipboard.setData(new ClipboardData(
                                              text: items[index].title +
                                                  '\n' +
                                                  items[index]
                                                      .amount
                                                      .toString() +
                                                  '\n' +
                                                  _mf.format(
                                                      items[index].time)));
                                        },
                                      ),
                                      new IconSlideAction(
                                        caption: 'Delete',
                                        color: Theme.of(context).primaryColor
                                      
                                ,
                                        icon: Icons.delete,
                                        onTap: () async {
                                          await widget
                                              .applicationModel.accountModel
                                              .removeTransaction(
                                                  items[index].id)
                                              .then((onValue) {
                                            items.removeAt(index);
                                          });

                                          await widget.applicationModel
                                              .accountCategoryModel
                                              .loadSummaryInfo(
                                                  widget
                                                      .applicationModel
                                                      .accountModel
                                                      .category
                                                      .accountCategory
                                                      .id,
                                                  widget.applicationModel
                                                      .accountModel.dateFilter);
                                        },
                                      ),
                                    ],
                                  );
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

          floatingActionButton: AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child:
             FloatingActionButton.extended(
                heroTag: 'fab_new_task',
                icon: Icon(Icons.add),
              //  backgroundColor: _color,
                label:  Observer(builder: (context) {
          return Text(widget.applicationModel.commonModel.lng['add_new']);
                  }),
                onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTransactionScreen(
                          accountCategory: widget.category.accountCategory,
                          applicationModel: widget.applicationModel,
                        ),
                      ),
                    );
                },
              )
            ,
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
