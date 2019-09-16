
import 'package:essential/serializers/date_filter.dart';
import 'package:essential/utils/Languages.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


part 'common_model.g.dart';

// Needs a constructor
class CustomColor extends Color {
  CustomColor(int value) : super(value);
}

class CommonModel = CommonModelBase with _$CommonModel;

abstract class CommonModelBase with Store {
  @observable
  Map<String,String> lng = en;

  @observable
  String currentLng = 'English';

  @observable
  double scrollPosition = 0.0;


  @observable
  DateFilter dateFilter = DateFilter(Constants.defaultFiltertype, DateTime.now());



  @observable
  CustomColor animatedColor = CustomColor(0xFF323CCE);

  @observable
  int backColor = ColorUtils.defaultColors[0].value;


  @action 
  void setDateFilter(DateTime value,int timeStampOption ){
    dateFilter = DateFilter(timeStampOption, value);
    
  }

@action 
  void setLng(String value){
    currentLng = value;
    lng = Lng().data[value];
  }

  @action 
  void setScrollPosition(double value){
    scrollPosition = value;
  }

  @action
  void setBackColor(int color){
    backColor = color;
    print('sert back color');
  }

  @action
  void setColor(ColorTransition color){
    animatedColor = CustomColor(color.blendedColor.hashCode);

  }

  @observable
  Observable<int> observcount = Observable(0);


}
