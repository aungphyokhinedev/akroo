
import 'package:essential/utils/constants.dart';

class DateFilter {
  int durationType;
  DateTime selectedDate;
  DateTime start;
  DateTime end;

  DateFilter(int type, DateTime selected){
    this.selectedDate = selected;
    this.durationType = type;
    if(type == Constants.timestampOptionDay){
      this.start = new DateTime(selected.year,selected.month, selected.day,0).toUtc();
      this.end = this.start.add(new Duration(days: 1));
    }
    else if(type == Constants.timestampOptionMonth){
      this.start = new DateTime(selected.year,selected.month, 1, 0);
      if(selected.month == 12){
        this.end = new DateTime(selected.year + 1,1, 1, 0);
      }
      else{
        this.end = new DateTime(selected.year,selected.month + 1, 1, 0);
      }
     
    }
    else{
      this.start = new DateTime(selected.year,1, 1,0);
      this.end = new DateTime(selected.year + 1,1, 1,0);
    }
  }

}