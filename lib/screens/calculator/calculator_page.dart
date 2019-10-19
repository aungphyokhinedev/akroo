import 'package:essential/store/price_list_model.dart';
import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/buildin_transformers.dart';
import 'package:essential/widgets/calculator/home.dart';
import 'package:essential/widgets/date_picker/calendar_date_picker.dart';
import 'package:essential/widgets/date_picker/date_picker.dart';
import 'package:essential/widgets/gradient_background.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class CalculatorPage extends KFDrawerContent {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  
  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;

    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            padding: EdgeInsets.only(left: 0),
            icon: new Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () =>  widget.onMenuPressed(),
          ),
          elevation: 0,
          iconTheme: CustomTheme.of(context).iconTheme,
            brightness: CustomTheme.of(context).brightness,
          backgroundColor: Colors.transparent,
          actions: [
            
          ],
        ),
        body:
    
    Stack(alignment: Alignment.topCenter, children: <Widget>[
  // GradientBackground(color: Colors.blueGrey[600]) ,
     Calculator()
    ]));
  }
}
