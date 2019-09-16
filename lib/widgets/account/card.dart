
import 'package:essential/screens/account/add_card_screen.dart';
import 'package:essential/screens/account/card_screen.dart';
import 'package:essential/serializers/account_category.dart';

import 'package:essential/store/application_model.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';


class AccountCard extends StatefulWidget {
  final AccountCategory category;
  final ApplicationModel applicationModel;
  AccountCard({Key key, this.category, this.applicationModel}) : super(key: key);

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
   
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
                    return buildContent(widget.category,widget.applicationModel);
                  },
                ),
              ),
            );
    
    
    
  
  }

  Widget buildContent(AccountCategory category, ApplicationModel applicationModel) {
    


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
                builder: (context) => AddCardScreen(applicationModel),
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
                   Observer(builder: (_) {
               return  Text(
                  applicationModel.commonModel.lng['add_category'],
                  style: TextStyle(color: color),
                );
                   })
              ],
            ),
          ),
        ),
      );
    } else {

// widget.applicationModel.accountModel.setCategory(category.id);
    

      return    InkWell(
        onTap: () { 

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AccountCardScreen(accountCategory: category,applicationModel: applicationModel))
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: ColorUtils.getColorFrom(id:category.color),
                      //  style: BorderStyle.solid,
                        width: 0.0),
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
         Observer(builder: (_) {


          if( applicationModel.accountModel.summaryInfo == null){
            return CircularProgressIndicator();
          }

          var _info = applicationModel.accountModel.summaryInfo;
          double _total = _info.expense + _info.income;
          _total = _total == 0 ? 1 : _total;
          var _nf = new NumberFormat.compact();
          double _limit = 0.0;
          if(applicationModel.commonModel.dateFilter.durationType == 
          Constants.timestampOptionDay) {
            _limit = applicationModel.accountModel.accountCategory.dailyLimit != null ?
            applicationModel.accountModel.accountCategory.dailyLimit : 0.0;
          }
          else if(applicationModel.commonModel.dateFilter.durationType == 
          Constants.timestampOptionMonth) {
            _limit = applicationModel.accountModel.accountCategory.monthlyLimit != null ?
            applicationModel.accountModel.accountCategory.monthlyLimit : 0.0;
          }


        


           return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                 
                  SparkGraph(
                    expense: _info.expense/_total * 100 , 
                    income: _info.income/_total * 100, 
                    limit: _limit > 0 ? _info.expense/_limit * 100: 0.0,
                    color:ColorUtils.getColorFrom(id:category.color)),
                    Center(child:Column(children: <Widget>[
                   _info.expense > 0 ? Text('out ${_nf.format(_info.expense)}',
                    style: TextStyle(
                      color: Colors.black54,
                    ),):Container(),
                   _info.income > 0 ? Text('in ${_nf.format(_info.income)}',
                    style: TextStyle(
                      color: Colors.black54,
                    )):Container(),
                  ],))
                ],)  ,)
               ,
             //  Text(
             //    'income ${_info.income}'
             //  ),
             //  Text(
             //    'expense ${_info.expense}'
             // ),
                
              ]);
         }),
          Observer(builder: (_) {
          double _limit = 0.0;
          String _limitStr = '';
          var _nf = new NumberFormat.compact();
          var _date = applicationModel.commonModel.dateFilter.selectedDate;
          if(applicationModel.commonModel.dateFilter.durationType == 
          Constants.timestampOptionDay) {
            var _df = new DateFormat('MMM dd');
            _limitStr =  _df.format(_date) + ", ";
            _limit = applicationModel.accountModel.accountCategory.dailyLimit != null ?
            applicationModel.accountModel.accountCategory.dailyLimit : 0.0;
          }
          else if(applicationModel.commonModel.dateFilter.durationType == 
          Constants.timestampOptionMonth) {
            var _df = new DateFormat('yyyy MMM');
            _limitStr =  _df.format(_date) + ", ";
            _limit = applicationModel.accountModel.accountCategory.monthlyLimit != null ?
            applicationModel.accountModel.accountCategory.monthlyLimit : 0.0;
          }
          
          _limitStr  = _limitStr + (_limit > 0 ? _nf.format(_limit): ' -' ) + ' ' + 
          applicationModel.commonModel.lng['limit'];
           return Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                    
                      height: 60,
                     // alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         Text(
                              
                              category.name,
                              style: TextStyle(
                                height: 1,
                                fontSize: 25.0, 
                                color:Colors.black87),
                              softWrap: false,
                            ),
                            Text(_limitStr,
                            style: TextStyle(
                                height: 1.5,
                                fontSize: 13.0, 
                                color:Colors.grey))
                            
                        ],
                      )
                      
                    ),
                  ),
                );
          }),
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


class SparkGraph extends StatelessWidget {
  final double income;
  final double expense;
  final double limit;
  final Color color;
  SparkGraph({
    @required this.income,
    @required this.expense,
    @required this.limit,
    @required this.color,
  });

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {

    return AnimatedCircularChart(
  key: _chartKey,
  size: const Size(280.0, 280.0),
  initialChartData: <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(
          income,
          this.color,
          rankKey: 'completed',
        ),
        new CircularSegmentEntry(
          expense,
          Colors.grey,
          rankKey: 'completed',
        ),
      ],
      rankKey: 'progress',
    ),
    new CircularStackEntry(
      <CircularSegmentEntry>[
     
        new CircularSegmentEntry(
          limit,
          Colors.orange,
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    ),
   
  ],
  chartType: CircularChartType.Radial,
  edgeStyle: SegmentEdgeStyle.round,
  percentageValues: true,
);
  }
}