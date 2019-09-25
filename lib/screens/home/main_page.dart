import 'package:essential/widgets/account/cards.dart';
import 'package:essential/widgets/account/date_picker.dart';
import 'package:essential/widgets/home/background.dart';
import 'package:essential/widgets/home/header.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class MainPage extends KFDrawerContent {
  MainPage({
    Key key,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Background(),
         
        
        Header((){
          widget.onMenuPressed();
        }),
        DateDrawer(),
        AccountCards(applicationModel:_applicationModel),
      ],
   
          
    )  ;
  }
}
