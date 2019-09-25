
import 'package:essential/serializers/date_filter.dart';
import 'package:essential/utils/Languages.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  @observable
  bool isOnBoarded;

  @observable
  bool isLoading;

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

  @action
  Future<bool> getOnboardingDone()async{
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    isOnBoarded = prefs.getBool('isOBDone') == true?? false;
    isLoading = false;
    return isOnBoarded;
  }

  @action
   Future<void> setOnboardingDone(bool value)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOBDone', value);
  }

  @observable
  Observable<int> observcount = Observable(0);


}
