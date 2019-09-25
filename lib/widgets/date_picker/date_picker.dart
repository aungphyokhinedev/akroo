

import 'package:essential/store/application_model.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/date_picker/tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../inheriteddataprovider.dart';
import 'common.dart';
import 'date_widget.dart';



class DatePickerTimeline extends StatefulWidget {
  double dateSize, daySize, monthSize;
  Color dateColor, monthColor, dayColor;
  Color selectionColor;
  DateTime startDate, setDate;
  DateChangeListener onDateChange;
  // Creates the DatePickerTimeline Widget
  DatePickerTimeline( {
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
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePickerTimeline> {
  @override
  void initState() {
   // widget.currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
  //  final _applicationModel = InheritedDataProvider.of(context).applicationModel;
   
    return   Observer(builder: (context) {
      
//DateTime _setDate = _applicationModel.commonModel.dateFilter.selectedDate;
//DateTime _startDate = DateTime.now().add(new Duration(days: 1));
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      child: ListView.builder(
        itemCount: 500,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // Return the Date Widget
         
          DateTime date = widget.startDate.subtract(Duration(days: index));
          bool isSelected = compareDate(date,widget.setDate);

          return DateWidget(
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
              // A date is selected
              if (widget.onDateChange != null) {
                widget.onDateChange(selectedDate);
              }
            },
          );
        },
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