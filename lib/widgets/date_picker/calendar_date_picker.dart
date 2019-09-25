

import 'dart:async';

import 'package:essential/store/application_model.dart';
import 'package:essential/widgets/date_picker/tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tuple/tuple.dart';

import '../inheriteddataprovider.dart';
import 'calendar_date_widget.dart';
import 'common.dart';
import 'date_widget.dart';



class CalendarDatePickerTimeline extends StatefulWidget {
  double dateSize, daySize, monthSize;
  Color dateColor, monthColor, dayColor;
  Color selectionColor;
  DateTime startDate, setDate;
  DateChangeListener onDateChange;
  // Creates the DatePickerTimeline Widget
  CalendarDatePickerTimeline( {
    Key key,
    this.dateSize = Dimen.dateTextSize,
    this.daySize = Dimen.dayTextSize,
    this.monthSize = Dimen.monthTextSize,
    this.dateColor = AppColors.defaultDateColor,
    this.monthColor = AppColors.defaultMonthColor,
    this.dayColor = AppColors.defaultDayColor,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.setDate,
    this.startDate,
    this.onDateChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _CalendarDatePickerState();
}

class _CalendarDatePickerState extends State<CalendarDatePickerTimeline> {

   ScrollController _scrollController;
   DateTime _setDate;
  @override
  void initState() {
    _scrollController = new ScrollController();
    setState(() {
      _setDate = DateTime.now();
    });
   // widget.currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
  //  final _applicationModel = InheritedDataProvider.of(context).applicationModel;

    return   Observer(builder: (context) {
      
List<DateTime> _items = new List<DateTime>();
for (int i = 0; i < 700; i++) {
  DateTime date = widget.startDate.subtract(Duration(days: i));
  
  _items.add(date);
  // _scrollController.animateTo(i * widget.dateSize, duration: new Duration(seconds: 2), curve: Curves.ease);
}

Timer(Duration(milliseconds: 1000), () {
  for (int i = 0; i < _items.length; i++) {
                  bool isSelected = compareDate(_items[i],_setDate);
                  if(isSelected){
                    _scrollController.animateTo(i * 66.0, duration: new Duration(seconds: 2), curve: Curves.ease);
                  }
                   
                }
});
  

//DateTime _setDate = _applicationModel.commonModel.dateFilter.selectedDate;
//DateTime _startDate = DateTime.now().add(new Duration(days: 1));
    return Container(
      height: 80,
      child: ListView(
        controller: _scrollController,
         children: _items.map((DateTime date) {
           bool isSelected = compareDate(date,_setDate);
           return
           Container(
             width: 66,

             child: CalendarDateWidget(
            
            date: date,
            dateColor: widget.dateColor,
            dateSize: widget.dateSize,
            dayColor: widget.dayColor,
            daySize: widget.daySize,
            monthColor: widget.monthColor,
            monthSize: widget.monthSize,
            selectionColor:
                isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate) {
            
              if (widget.onDateChange != null) {
               _setDate = selectedDate;
                for (int i = 0; i < _items.length; i++) {
                  bool isSelected = compareDate(_items[i],_setDate);
                  if(isSelected){
                    _scrollController.animateTo(i * 66.0, duration: new Duration(seconds: 2), curve: Curves.ease);
                  }
                   
                }
                widget.onDateChange(selectedDate);
              }
            },
          ),)
            ;
       
        }).toList(),

        scrollDirection: Axis.horizontal,

      ),
    );
    });
  }

  bool compareDate(DateTime date1, DateTime date2) {
    String date1String =
        date1.day.toString() + date1.month.toString() + date1.year.toString();
    String date2String =
        date2.day.toString() + date2.month.toString() + date2.year.toString();

    return date1String == date2String;
  }
}