
import 'package:essential/screens/todo/detail_screen.dart';
import 'package:essential/store/common_model.dart';
import 'package:essential/store/todo_model.dart';
import 'package:essential/screens/todo/add_card_screen.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/utils/CustomColors.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:flutter/foundation.dart';

import '../utils/CustomIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import './TodoDetail.dart';
import 'inheriteddataprovider.dart';


class TodoCard extends StatefulWidget {
  final TaskCategory category;

  TodoCard({Key key, this.category}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
     final _commonmodel = InheritedDataProvider.of(context).applicationModel.commonModel;
    final _todomodel = InheritedDataProvider.of(context).applicationModel.toDoModel;
    return Container(
              margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 4.0,
                    spreadRadius: -2.0,
                    offset: Offset(0.0, 1.0),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: LayoutBuilder(
                  builder: (_, BoxConstraints constraints) {
                    // 352.6 is iPhone 8+ width
                    // 417.9 is iPhone 8+ height for this widget
                    final scale = constraints.maxHeight / 417.9;
                    return buildContent(widget.category, _todomodel, _commonmodel);
                  },
                ),
              ),
            );
    
    
    
  
  }

  Widget buildContent(TaskCategory category, ToDoModel todo, CommonModel common) {
  final _applicationModel = InheritedDataProvider.of(context).applicationModel;
  
    if (category.isAdd != null &&  category.isAdd) {
      Color color = ColorUtils.getColorFrom(id:category.color);
      return  Material(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCardScreen(_applicationModel),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 52.0,
                  color: color,
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                  'Add Category',
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return    InkWell(
        onTap: () { 
       
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(taskCategory: category,applicationModel: _applicationModel))
                );
                },
        child: Hero(
            tag: "avatar_" + widget.category.name,
            child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.grey.withAlpha(70),
                        style: BorderStyle.solid,
                        width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      IconData(
            category.logo,
            fontFamily: 'MaterialIcons',
          ),
                      color: ColorUtils.getColorFrom(id:category.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Material(
                            color: Colors.transparent,
                            child: Text(
                              " Tasks",
                              style: TextStyle(),
                              softWrap: false,
                            )))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        category.name,
                        style: TextStyle(fontSize: 30.0),
                        softWrap: false,
                      ),
                    ),
                  ),
                ),
              ])
        ],
      )

            
            ));
      
      
    }
  }
}

class LinearToken {
  final int day;
  final int value;

  LinearToken(this.day, this.value);
}
