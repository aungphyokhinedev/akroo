import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/account_transaction.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';
import 'package:essential/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends StatefulWidget {
  final AccountCategory accountCategory;
  final ApplicationModel applicationModel;

  AddTransactionScreen({
    @required this.accountCategory,
    @required this.applicationModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddTransactionScreenState();
  }
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  AccountTransaction newTransaction;
  bool _titleError = false;
  bool _amountError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      newTransaction = new AccountTransaction();
      newTransaction.time = widget.applicationModel.commonModel.dateFilter.selectedDate;
      newTransaction.cid = widget.accountCategory.id;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var yearFormatter = new DateFormat('MMMM yyy');
    var dateFormatter = new DateFormat('dd EE');
    var timeFormatter = new DateFormat('hh:mm');

    bool checkError () {
      if(newTransaction.title.isEmpty){
        setState(() {
          _titleError = true;
        });
        return true;
      }

      if(newTransaction.amount <= 0){
        setState(() {
          _amountError = true;
        });
        return true;
      }
      return false;
    }  

    var _color = ColorUtils.getColorFrom(id: widget.accountCategory.color);
    return Scaffold(
      key: _scaffoldKey,
   //   backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: CustomTheme.of(context).iconTheme,
        brightness:Theme.of(context).brightness ,
        leading: new IconButton(
            padding: EdgeInsets.only(left: 0),
            icon: new Icon(
              Icons.arrow_back_ios,

            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        title:
        Observer(builder: (context) {
          return Text(
          widget.applicationModel.commonModel.lng['add_new'],
          style: Theme.of(context)
                 .textTheme
                  .subhead
          
           ,
        );
        }),
        centerTitle: true,
        elevation: 0,
       
     //   brightness: Brightness.light,
        backgroundColor: Colors.transparent,
      ),
      body:
       Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal:  SizeConfig.blockSizeVertical * 2.5, vertical:  SizeConfig.blockSizeVertical * 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What transaction are you planning to add?',
              style: CustomTheme.of(context).textTheme.body1.copyWith(
                fontWeight: FontWeight.w600,
                  fontSize:  SizeConfig.blockSizeVertical * 2.1
              )
              
            
            ),
             Container(
              height: 16.0,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[

                InkWell(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
  Text('${yearFormatter.format(newTransaction.time)}',
                   style: TextStyle(
//                  fontWeight: FontWeight.w500,
                  fontSize:  SizeConfig.blockSizeVertical * 2.1)
                  ),
                    Text('${dateFormatter.format(newTransaction.time)}',
                   style: TextStyle(
          //        color: Colors.black38,
                   fontWeight: FontWeight.w500,
                  fontSize:  SizeConfig.blockSizeVertical * 2.1,
                )
                  )
                  ],)
                  
                 ,
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 1, 1),
                        maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      
                      DateTime newDate = new DateTime(date.year, date.month, date.day,
                       newTransaction.time.hour,  
                       newTransaction.time.minute, 
                       0, 0,0);
                       var currentFilter = widget.applicationModel.commonModel.dateFilter;
                       widget.applicationModel.commonModel.setDateFilter(newDate, currentFilter.durationType);

                       setState(() {
                          newTransaction.time = newDate;
                        });
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
                ],),
                
                InkWell(
                  child: Text('${timeFormatter.format(newTransaction.time)}',
                   style: TextStyle(
                //  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.blockSizeVertical * 2.1)),
                  onTap: () {
                    DatePicker.showTimePicker(context, 
                   
                    showTitleActions: true,
                        onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                       DateTime newDate = new DateTime(
                         newTransaction.time.year, 
                         newTransaction.time.month, 
                         newTransaction.time.day,
                       date.hour,  
                       date.minute, 
                       0, 0,0);

                       setState(() {
                          newTransaction.time = newDate;
                        });
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                )
              ],
            ),
            Container(
              height: 16.0,
            ),
          Observer(builder: (context) {
          return   TextField(
              onChanged: (text) {
                setState(() {
                   _titleError = false;
                  newTransaction.title = text;
                });
              },
              cursorColor: _color,
              autofocus: true,
              decoration: InputDecoration(
                  errorText: _titleError ? 'Value Can\'t Be Empty' : null,
                  border: InputBorder.none,
                  hintText: widget.applicationModel.commonModel.lng['your_title'] + '...',
                  hintStyle: TextStyle(
             //       color: Colors.black26,
                  )),
              style: TextStyle(
             //     color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize:  SizeConfig.blockSizeVertical * 4),
            );
          }),
            
            Observer(builder: (context) {
          return  TextField(
              onChanged: (text) {
                setState(() {
                  _amountError = false;
                  newTransaction.amount = double.parse(text);
                });
              },
              keyboardType: TextInputType.number,
              cursorColor: _color,
              autofocus: true,
              decoration: InputDecoration(
                errorText: _amountError ? 'Value Can\'t Be Empty' : null,
                  border: InputBorder.none,
                  hintText: widget.applicationModel.commonModel.lng['amount'],
                  hintStyle: TextStyle(
             //       color: Colors.black26,
                  )),
              style: TextStyle(
               //   color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            );
            }),
            Container(
              height: 30.0,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton.extended(
                //  heroTag: 'fab_new_task',
                icon: Icon(Icons.arrow_downward),
              //  backgroundColor: _color,
                label: 
                  Observer(builder: (context) {
          return Text(widget.applicationModel.commonModel.lng['expense']);
                  }),
                onPressed: () async {
                  if (checkError()) {
                    final snackBar = SnackBar(
                      content: Text(
                          'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                      backgroundColor: _color,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    newTransaction.type = Constants.transactionExpense;
                    await widget.applicationModel.accountModel.addTransaction(newTransaction);
                    //  await widget.todoModel.addTaskTodo(
                    //   new TaskTodo(name:newTask, isDone: false,time: DateTime.now(), catId: widget.taskCategory.id )
                    // );
                    await widget.applicationModel.accountModel.refresh();
                    await widget.applicationModel.accountCategoryModel.loadSummaryInfo(
                      widget.applicationModel.accountModel.category.accountCategory.id,
                      widget.applicationModel.accountModel.dateFilter
                    );
                    // widget.todoModel.getTaskTodoList(widget.taskCategory.id);
                    Navigator.pop(context);
                  }
                },
              ),
              SizedBox(width: 5),
              FloatingActionButton.extended(
                heroTag: 'fab_new_task',
                icon: Icon(Icons.arrow_upward),
            //    backgroundColor: _color,
                label:  Observer(builder: (context) {
          return Text(widget.applicationModel.commonModel.lng['income']);
                  }),
                onPressed: () async {
                  if (checkError()) {
                    final snackBar = SnackBar(
                      content: Text(
                          'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                      backgroundColor: _color,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                   newTransaction.type = Constants.transactionIncome;
              await      widget.applicationModel.accountModel.addTransaction(newTransaction);
           await widget.applicationModel.accountModel.refresh();
           await  widget.applicationModel.accountCategoryModel.loadSummaryInfo(
                                  widget.applicationModel.accountModel.category.accountCategory.id,
                      widget.applicationModel.accountModel.dateFilter
           );
                    //  await widget.todoModel.addTaskTodo(
                    //   new TaskTodo(name:newTask, isDone: false,time: DateTime.now(), catId: widget.taskCategory.id )
                    // );
                    // widget.todoModel.getTaskTodoList(widget.taskCategory.id);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}

// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
