import 'package:essential/widgets/calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Calculator extends StatefulWidget{
  @override
  State createState() => new _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
 


  @override
  Widget build(BuildContext context) {
    return  new  CalculatorWidget(Colors.blueGrey,Colors.orange,Colors.white);
  }




}
