

import 'package:essential/store/application_model.dart';
import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:flutter/services.dart';


class CalculatorListScreen extends StatefulWidget {
  final ApplicationModel applicationModel;
  CalculatorListScreen({
    @required this.applicationModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _CalculatorListScreenState();
  }
}

class _CalculatorListScreenState extends State<CalculatorListScreen>
    with SingleTickerProviderStateMixin {

  ScrollController _scrollController;
  String message;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    widget.applicationModel.calculateModel.refresh();
  }

   _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      widget.applicationModel.calculateModel.next();

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

 var _mf = new DateFormat('dd/MM/yy');
 var _df = new DateFormat('hh:mm');
  String _selectedId;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
            
          ],
        ),
        body: Observer(builder: (_) {
          var items = widget.applicationModel.calculateModel.grouplists;
          var pagination = widget.applicationModel.calculateModel.pagination;
          var moment = new Moment.now();
          var _load = widget.applicationModel.calculateModel.isLoading;
          return items.length == 0
              ? Center(
                  child: Column(
                  children: _load
                      ? <Widget>[Text('Loading transaction.')]
                      : <Widget>[
                          Text('Currently no calculation history.'),
                        ],
                ))
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeVertical * 1.5,
                      vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0.0),
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
                                  style: CustomTheme.of(context).textTheme.body1,
                                ),
                              ),
                              Container(
                                child: Text(
                                    'Saved Calculations',
                                    style:CustomTheme.of(context).textTheme.title.copyWith(
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
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1),
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
                                     // color: Colors.white,
                                      child: InkWell(
                                        onTap: (){
                                          widget.applicationModel.calculateModel.setCurrentGroup(
                                          items[index]
                                        );
                                         Navigator.of(context).pop();
                                              
                                        },
                                       
                                        child:
                                        Padding(padding: EdgeInsets.symmetric(
                                          vertical: SizeConfig.blockSizeVertical * 2
                                        )
                                        ,
                                        child: 
                                         Container(
                                         
                                          child: 
                                          Column(
                                            children: <Widget>[
                                           
                                          Row(
                                            
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(children: <Widget>[

                                            
                                              Container(width: SizeConfig.blockSizeVertical * 2,),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    items[index].name,
                                                    
                                                    style: CustomTheme.of(context).textTheme.title.copyWith(
                                                      fontSize: SizeConfig.blockSizeVertical * 2
                                                    ),
                                                  ),
                                                
                                              
                                                 Text(
                                                          moment.from(items[index].time) ,
                                                          softWrap: true,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: CustomTheme.of(context).textTheme.body1),
                                                      
                                                       
                                                 
                                                  
                                                ],
                                              ),
                                              
                                                ],),
                                           
                                               
                                            ],
                                          ),
                                          
                                          ],
                                          )
                                        ),
                                        )
                                      )),
                                  actions: <Widget>[],
                                  secondaryActions: <Widget>[
                                  
                                    new IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () async {
                                        await widget.applicationModel.calculateModel.deleteCaculateGroup(
                                          items[index]
                                        );
                                            
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

       
         
     
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
