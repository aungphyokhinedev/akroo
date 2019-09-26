import 'package:essential/serializers/date_filter.dart';
import 'package:essential/utils/constants.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/common/transparent_button.dart';
import 'package:essential/widgets/date_picker/date_picker.dart';
import 'package:essential/widgets/date_picker/month_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../inheriteddataprovider.dart';

class DateDrawer extends StatefulWidget {
  @override
  _DateDrawerState createState() => _DateDrawerState();
}

class _DateDrawerState extends State<DateDrawer> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  int filterOption = Constants.timestampOptionMonth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
      vsync: this,
    );

    

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    
    /// _controller.reverse();
  }

  final List<ReactionDisposer> _disposers = [];

  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    final _applicationModel = InheritedDataProvider.of(context).applicationModel;
    
    
    _disposers.add(reaction((_) => _applicationModel.loginModel.isLoggedIn,
        (msg) => msg ? _controller.forward() : _controller.reverse()));
   
    _applicationModel.loginModel.isLoggedIn? _controller.forward() : _controller.reverse();
   

   

    return SizeTransition(
      sizeFactor: _animation,
      axisAlignment: -1.0,
      child: Container(
        height: SizeConfig.screenHeight ,
        margin: EdgeInsets.only(top:SizeConfig.blockSizeVertical *  22, bottom:SizeConfig.blockSizeVertical *  4),
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockSizeHorizontal * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              
              Observer(builder: (_) {
 

onDateChange(DateTime date, int type) {
    _applicationModel.commonModel.setDateFilter(date, type); 
    _applicationModel.accountModel.setDateFilter(new DateFilter(type, date));
    _applicationModel.accountCategoryModel.loadSummaryInfo(
      _applicationModel.accountModel.category.accountCategory.id,
      _applicationModel.accountModel.dateFilter
    );
  }
   
              DateTime setDate = _applicationModel.commonModel.dateFilter.selectedDate;
                if (_applicationModel.commonModel.dateFilter.durationType ==
                    Constants.timestampOptionDay) {
                  return DatePickerTimeline(
                       dateSize: SizeConfig.blockSizeVertical * 3 ,
                    daySize: SizeConfig.blockSizeVertical *1.3 ,
                     monthSize: SizeConfig.blockSizeVertical *1.3 ,
                  //  dateColor: Colors.white,
                    monthColor: Colors.white54,
                    dayColor: Colors.white54,
                    setDate: setDate,
                    startDate: DateTime.now().add(new Duration(days:1)),
                    onDateChange: (date) {
                      // New date selected
                     
                      onDateChange(date,Constants.timestampOptionDay);
                      print(date.day.toString());
                    },
                  );
                } else { 
                  return MonthPickerTimeline(
                  //  dateColor: Colors.white70,
                    dateSize: SizeConfig.blockSizeVertical * 3 ,
                    daySize: SizeConfig.blockSizeVertical *1.3 ,
                     monthSize: SizeConfig.blockSizeVertical *1.3 ,
                    monthColor: Colors.white54,
                    dayColor: Colors.white54,
                    setDate: setDate,
                    startDate: DateTime.now().add(new Duration(days:28)),
                    onDateChange: (date) {
                      // New date selected
                      print('date change');
                       onDateChange(date,Constants.timestampOptionMonth);
                      print(date.day.toString());
                    },
                  );
                }
              }), 
              Spacer(flex: 1,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   
                    Observer(builder: (context) {
                
                 onMonthPress() {
                    _applicationModel.commonModel.setDateFilter(
                  DateTime.now(),
                    Constants.timestampOptionMonth, 
                );
                }

                onDayPress() {
                  _applicationModel.commonModel.setDateFilter(
                  DateTime.now(),
                    Constants.timestampOptionDay, 
                );
                }
                var _lng = _applicationModel.commonModel.lng;
                return _applicationModel.commonModel.dateFilter.durationType == Constants.timestampOptionDay ?
                  TransparentButton(_lng['daily'], false,onMonthPress ):
                      TransparentButton(_lng['monthly'], false, onDayPress);
                    })
                  ],
                )
              ,
              //  _Progress(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    
    _disposers.forEach((disposer) => disposer());
    _controller.dispose();
    super.dispose();
  }
}
