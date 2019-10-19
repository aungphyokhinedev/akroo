
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/date_picker/tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../inheriteddataprovider.dart';
import 'common.dart';
import 'month_widget.dart';


class MonthPickerTimeline extends StatefulWidget {
  double dateSize, daySize, monthSize;
  Color dateColor, monthColor, dayColor;
  Color selectionColor;
    DateTime startDate, setDate;
  DateChangeListener onDateChange;

  // Creates the DatePickerTimeline Widget
  MonthPickerTimeline({
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
  State<StatefulWidget> createState() => new _MonthPickerState();
}

class _MonthPickerState extends State<MonthPickerTimeline> {
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    // final _applicationModel = InheritedDataProvider.of(context).applicationModel;
     SizeConfig().init(context);

   //   DateTime _setDate = _applicationModel.commonModel.dateFilter.selectedDate;
//DateTime _startDate = DateTime.now().add(new Duration(days: 30));
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      child: ListView.builder(
        itemCount: 500,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // Return the Date Widget
           DateTime datenow = widget.startDate;
            DateTime date =  new DateTime(datenow.year, datenow.month - index, 1);
       //   DateTime date = DateTime.now().subtract(Duration(days: index));
          bool isSelected = compareMonth(date,  widget.setDate,);

          return MonthWidget(
            date: date,
            dateColor: widget.dateColor,
            dateSize: widget.dateSize,
            dayColor: widget.dayColor,
            daySize: widget.daySize,
            monthColor: widget.monthColor,
            monthSize: widget.monthSize,
            selectionColor:
                isSelected ? widget.selectionColor : widget.dateColor ,
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
    
   
  }

  bool compareMonth(DateTime date1, DateTime date2) {
    String date1String =
         date1.month.toString() + date1.year.toString();
    String date2String =
         date2.month.toString() + date2.year.toString();

    return date1String == date2String;
  }
}