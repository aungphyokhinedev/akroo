import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/date_picker/tap.dart';
/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;
  final double dateSize, daySize, monthSize;
  final Color dateColor, monthColor, dayColor;
  final Color selectionColor;
  final DateSelectionCallback onDateSelected;

  DateWidget({
      @required this.date,
      @required this.dateSize,
      @required this.daySize,
      @required this.monthSize,
      @required this.dateColor,
      @required this.monthColor,
      @required this.dayColor,
      @required this.selectionColor,
      this.onDateSelected
  });

  @override
  Widget build(BuildContext context) {
         SizeConfig().init(context);
    var _padH = SizeConfig.blockSizeHorizontal * 2;
    var _padW = SizeConfig.blockSizeHorizontal * 4;
    return InkWell(
      child: Container(
       
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_padH)),
         // color: selectionColor,
        ),
        child: Padding(
          padding:  EdgeInsets.only(top: _padH, bottom: _padH, left: _padW, right: _padW),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(new DateFormat("MMM").format(date).toUpperCase(), // Month
                  style: TextStyle(
                    color: monthColor,
                    fontSize: monthSize,
                 //   fontFamily: 'Roboto',
                   // fontWeight: FontWeight.w500,
                  )),
              Text(date.day.toString(), // Date
                  style: TextStyle(
                    color: selectionColor,
                    fontSize: dateSize,
                 //   fontFamily: 'Roboto',
                   fontWeight: FontWeight.w500,
                  )),
              Text(new DateFormat("E").format(date).toUpperCase(), // WeekDay
                  style: TextStyle(
                    color: dayColor,
                    fontSize: daySize,
                //    fontFamily: 'Roboto',
                  //  fontWeight: FontWeight.w500,
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected !=null) {
          // Call the onDateSelected Function
          onDateSelected(this.date);
        }
      },
    );
  }
}