
import 'package:essential/screens/common/class_builder.dart';
import 'package:essential/screens/home/splash.dart';
import 'package:essential/store/account_category_model.dart';
import 'package:essential/store/account_model.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/store/calculate_model.dart';
import 'package:essential/store/calendar_model.dart';
import 'package:essential/store/common_model.dart';
import 'package:essential/store/login_model.dart';
import 'package:essential/store/price_list_model.dart';
import 'package:essential/store/todo_model.dart';
import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/MyThemes.dart';
import 'package:essential/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'widgets/inheriteddataprovider.dart';


void main() {
   ClassBuilder.registerClasses();
  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final accountData = AccountModel();
  final categoryData = AccountCategoryModel();
  final commonData = CommonModel();
  final todoData = ToDoModel();
  final loginModel = LoginModel();
  final calendarModel = CalendarModel();
  final priceListModel = PriceListModel();
  final calculateModle = CalculateModel();
  @override
  Widget build(BuildContext context){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    commonData.setDateFilter(DateTime.now(), Constants.timestampOptionMonth);


    return MaterialApp(
      title: 'Essential',
      theme: CustomTheme.of(context),
      debugShowCheckedModeBanner: false,
      home: InheritedDataProvider(
        child:Splash()
          ,
      // HomePage(),
        applicationModel: new ApplicationModel(
          accountData,
          categoryData,
          commonData,
          todoData,
          loginModel,
          calendarModel,
          priceListModel,
          calculateModle
        ),
      ),
    );
  }
}
