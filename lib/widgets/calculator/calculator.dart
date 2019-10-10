import 'dart:async';

import 'package:essential/screens/calculator/calculator_list.dart';
import 'package:essential/serializers/calcuate_group.dart';
import 'package:essential/serializers/calculate_data.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/utils/CustomIcons.dart';
import 'package:essential/utils/my_flutter_app_icons.dart';
import 'package:essential/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:url_launcher/url_launcher.dart';

import '../inheriteddataprovider.dart';

//Global variables
//For Appbar Colors

String strInput = "";

class CalculatorWidget extends StatefulWidget {
  final Color backColor;
  final Color textColor;
  final Color buttonColor;

  CalculatorWidget(this.backColor, this.buttonColor, this.textColor);
  @override
  State createState() => new CalculatorWidgetState();
}

class CalculatorWidgetState extends State<CalculatorWidget>
    with TickerProviderStateMixin {
  //Text Controllers for taking inputs and showing results
  final textControllerInput = TextEditingController();
  final textControllerResult = TextEditingController();
  String optInput;
  bool _isDialogueOpen = false;
  double _textSize;
  double _buttonSize;
  double _opButtonSize;
  double _animatedHeight = 0;
  double _initial = 0.0;
  double _percentage = 0.0;
  bool _upOrDown = false;
  bool _keyboradExpend = false;
  @override
  void initState() {
    super.initState();

    // Start listening to changes
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    textControllerInput.dispose();
    textControllerResult.dispose();
    super.dispose();
  }

  TextEditingController _textExpController = TextEditingController();
  TextEditingController _textNameController = TextEditingController();
  _displayDialog(BuildContext context, int index) async {
    var _data = _applicationModel.calculateModel.items[index];
    _textExpController.text = _data.expression ?? "";
    _textNameController.text = _data.name ?? "";
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Edit Dialog'),
            content: ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 0.0,
                maxHeight: SizeConfig.blockSizeVertical * 11,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Expression'),
                  CupertinoTextField(
                    controller: _textExpController,
                    placeholder: "Calculation",
                    autofocus: true,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.0,
                        color: Color(0x00FFFFFF),
                      ),
                    ),
                    //   decoration: InputDecoration(hintText: "Calculation"),
                  ),
                  CupertinoTextField(
                    controller: _textNameController,
                    placeholder: "Description",
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.0,
                        color: Color(0x00FFFFFF),
                      ),
                    ),
                    //  decoration: InputDecoration(hintText: "Description"),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  _applicationModel.calculateModel.updateItem(
                      index,
                      new CalculateData(
                        serial: _data.serial,
                        id: _data.id,
                        type: _data.type,
                        name: _textNameController.text,
                        expression: _textExpController.text,
                        groupId: _data.groupId,
                      ));
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //This is the first Row of keys
  Row funcRowContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
            padding: EdgeInsets.all(_buttonSize),
            child: Icon(Icons.save_alt, color: Colors.lime),
            onPressed: () async {
              if (!_applicationModel.loginModel.isLoggedIn) {
                final snackBar = SnackBar(
                    content: Text('Need to login, To save your calculations.'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                Scaffold.of(context).showSnackBar(snackBar);
                return null;
              }

              List<CalculateData> _data =
                  _applicationModel.calculateModel.items;
              _textNameController.text = "";

              if (_applicationModel.calculateModel.currentGroup == null) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('Save this?'),
                        content: ConstrainedBox(
                          constraints: new BoxConstraints(
                            minHeight: 0.0,
                            maxHeight: SizeConfig.blockSizeVertical * 11,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Give save as name'),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical,
                              ),
                              CupertinoTextField(
                                controller: _textNameController,
                                placeholder: "Name",
                                autofocus: true,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.0,
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                // decoration: InputDecoration(hintText: "Save as Name"),
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('OK'),
                            onPressed: () {
                              _applicationModel.calculateModel.addCaculateGroup(
                                  CalculateGroup(
                                      name: _textNameController.text,
                                      time: DateTime.now(),
                                      list: _data));

                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text('CANCEL'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              } else {
                await _applicationModel.calculateModel.addCaculateGroup(
                    CalculateGroup(
                        name:
                            _applicationModel.calculateModel.currentGroup.name,
                        time: DateTime.now(),
                        list: _data));

                final snackBar = SnackBar(content: Text('Saving done!'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                Scaffold.of(context).showSnackBar(snackBar);
              }

              // _applicationModel.calculateModel.removeAll();

              //setBreakItem();
            }),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("AC",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  color: Colors.lime,
                  fontWeight: FontWeight.w300)),
          onPressed: () {
            _applicationModel.calculateModel.removeAll();
          },
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(Icons.history, color: Colors.lime),
          onPressed: () => setState(() {
            if (!_applicationModel.loginModel.isLoggedIn) {
              final snackBar =
                  SnackBar(content: Text('Please, Login firstly.'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
              Scaffold.of(context).showSnackBar(snackBar);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalculatorListScreen(
                    applicationModel: _applicationModel,
                  ),
                ),
              );
            }
          }),
        ),
        new Container(
            // width: _opButtonSize,
            child: Container()),
        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("/", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "/";}),),
      ],
    );
  }

  //This is the first Row of keys
  Row buttonsRow0Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("(",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "(";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text(")",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + ")";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("^",
              style: TextStyle(
                fontSize: _textSize,
                color: Colors.white,
                // fontWeight: FontWeight.w300
              )),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "^";
          }),
        ),
        new Container(
            //   width: _opButtonSize,
            child: FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(
            MyFlutterApp.divide,
            color: Colors.white,
            size: SizeConfig.blockSizeVertical * 2.1,
          ),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "/";
          }),
        )),
        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("/", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "/";}),),
      ],
    );
  }

  //This is the first Row of keys
  Row buttonsRow1Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("7",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "7";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("8",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "8";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("9",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "9";
          }),
        ),
        new Container(
            //    width: _opButtonSize,
            child: FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(
            MyFlutterApp.cancel,
            color: Colors.white,
            size: SizeConfig.blockSizeVertical * 2.1,
          ),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "*";
          }),
        )),
        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("/", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "/";}),),
      ],
    );
  }

  //This is the second Row of keys
  Row buttonsRow2Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("4",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "4";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("5",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "5";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("6",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "6";
          }),
        ),
        new Container(
            //   width: _opButtonSize,
            child: FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(
            MyFlutterApp.minus,
            color: Colors.white,
            size: SizeConfig.blockSizeVertical * 2.1,
          ),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "-";
          }),
        )),
        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("x", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "*";}),),
      ],
    );
  }

  //This is the third Row of keys
  Row buttonsRow3Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("1",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "1";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("2",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "2";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("3",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "3";
          }),
        ),
        new Container(
            //       width: _opButtonSize,
            child: FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(
            MyFlutterApp.plus,
            color: Colors.white,
            size: SizeConfig.blockSizeVertical * 2.1,
          ),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "+";
          }),
        )),
        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("-", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "-";}),),
      ],
    );
  }

  //This is the second Row of keys
  Row buttonsRow4Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text(".",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + ".";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Text("0",
              style: TextStyle(
                  fontSize: _textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w300)),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "0";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(IconData(58842, fontFamily: 'MaterialIcons'),
              color: Colors.white),
          onPressed: () {
            setExpItem();
          },
        ),
        Container(
            //          width: _opButtonSize,
            child: FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(Icons.backspace, size: _textSize, color: Colors.lime),
          onPressed: () {
            textControllerInput.text = (textControllerInput.text.length > 0)
                ? (textControllerInput.text
                    .substring(0, textControllerInput.text.length - 1))
                : "";
          },
        ))
        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("+", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "+";}),)
      ],
    );
  }

  //This is the second Row of keys
  Row buttonsRow5Container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(Icons.save, color: Colors.white54),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + ".";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(Icons.list, color: Colors.white54),
          onPressed: () => setState(() {
            textControllerInput.text = textControllerInput.text + "0";
          }),
        ),
        new FlatButton(
          padding: EdgeInsets.all(_buttonSize),
          child: Icon(
            Icons.search,
            color: Colors.white54,
          ),
          onPressed: () {
            textControllerInput.text = (textControllerInput.text.length > 0)
                ? (textControllerInput.text
                    .substring(0, textControllerInput.text.length - 1))
                : "";
          },
        ),
        Container(),

        //  new FlatButton(padding: EdgeInsets.all(_buttonSize),child: Text("+", style: TextStyle(fontSize: _textSize, color: widget.textColor, fontWeight: FontWeight.w300)),color: widget.buttonColor,onPressed:()=>setState(() {textControllerInput.text = textControllerInput.text + "+";}),)
      ],
    );
  }

  String _prepareExp() {
    setExpItem();
    String _input = "";

    _applicationModel.calculateModel.items.forEach((item) {
      print(item.type);
      if (item.type == CalculateData.TYPE_EXPRESSION) {
        _input = _input + " ${item.expression}";
      }
    });
    // _input = _input + textControllerInput.text;
    print(_input);

    return _input;
  }

  String _calculateResult(String _input) {
    try {
      //Calculate everything here
      // Parse expression:
      Parser p = new Parser();
      // Bind variables:
      ContextModel cm = new ContextModel();

      Expression exp = p.parse(_input);

      return exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (Exception) {
      return '';
    }
  }

  void setResultItem() {
    setExpItem();
    _applicationModel.calculateModel.addItem(new CalculateData(
        type: CalculateData.TYPE_RESULT,
        serial: _applicationModel.calculateModel.items.length));
  }

  void setBreakItem() {
    setExpItem();
    _applicationModel.calculateModel.addItem(new CalculateData(
        type: CalculateData.TYPE_BREAK,
        serial: _applicationModel.calculateModel.items.length));
  }

  void setExpItem() {
    if (textControllerInput.text.length > 0) {
      _applicationModel.calculateModel.addItem(new CalculateData(
          id: _applicationModel.calculateModel.items.length.toString(),
          type: CalculateData.TYPE_EXPRESSION,
          expression: textControllerInput.text,
          serial: _applicationModel.calculateModel.items.length + 1));
    }
    textControllerInput.text = '';
    Timer(Duration(milliseconds: 100),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }

  //This returns a Column for the keypad
  Widget keypadContainer() {
    return SwipeDetector(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              funcRowContainer(),
              buttonsRow0Container(),
              buttonsRow1Container(),
              buttonsRow2Container(),
              buttonsRow3Container(),
              buttonsRow4Container(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.5,
              ),
              RaisedButton(
                color: Colors.orange,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1.5,
                    horizontal: SizeConfig.blockSizeVertical * 3),
                onPressed: () {
                  setResultItem();
                  String _input = _prepareExp();
                  print('ssd $_input');
                  setState(() {
                    textControllerResult.text = _calculateResult(_input);
                  });
                },
                child: Text('CALCULATE',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        color: Colors.white)),
              ),
              // _keyboradExpend?
              // buttonsRow5Container():Container(height:SizeConfig.blockSizeVertical * 3)
            ],
          ),
        ],
      ),
      onSwipeUp: () {
        setState(() {
          _keyboradExpend = true;
        });
      },
      onSwipeDown: () {
        setState(() {
          _keyboradExpend = false;
        });
      },
    );
  }

  ScrollController _controller = ScrollController();

  ApplicationModel _applicationModel;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _buttonSize = SizeConfig.blockSizeVertical * 0;
    _textSize = SizeConfig.blockSizeVertical * 3;
    //  _animatedHeight = SizeConfig.blockSizeVertical * 10;
    _opButtonSize = SizeConfig.blockSizeVertical * 6;
    _applicationModel = InheritedDataProvider.of(context).applicationModel;

    return Observer(builder: (context) {
      var _items = _applicationModel.calculateModel.items;
      String _sExp = "";
      String _tExp = "";

      for (int i = 0; i < _items.length; i++) {
        if (_items[i].type == CalculateData.TYPE_EXPRESSION) {
          _sExp = _sExp + _items[i].expression;
          _tExp = _tExp + _items[i].expression;
        } else if (_items[i].type == CalculateData.TYPE_RESULT) {
          print('sExp $_sExp');
          var _sResult = _calculateResult(_sExp);
          _items[i].expression = _sResult;
          _sExp = _sResult;
          _tExp = _sResult;
        }
      }
      textControllerResult.text =
          _calculateResult(_sExp + textControllerInput.text);
      return Container(
          child: Padding(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
              //  color: widget.backColor,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _applicationModel.calculateModel.currentGroup != null
                          ? Text(
                              '${_applicationModel.calculateModel.currentGroup.name}',
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 2.2,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white))
                          : Container(),
                      new AnimatedSize(
                        vsync: this,
                        duration: new Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        child: ConstrainedBox(
                            constraints: new BoxConstraints(
                              minHeight: 0.0,
                              maxHeight: _upOrDown
                                  ? (SizeConfig.screenHeight -
                                      (SizeConfig.blockSizeVertical * 30))
                                  : SizeConfig.blockSizeVertical * 20,
                            ),
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeVertical * 1),
                                child: ListView.builder(
                                    controller: _controller,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: _items.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var _item = _items[index];
                                      if (_item.type ==
                                          CalculateData.TYPE_BREAK) {
                                        return Container(
                                          color: Colors.white10,
                                          height:
                                              SizeConfig.blockSizeVertical * .1,
                                        );
                                      }

                                      if (_item.type ==
                                          CalculateData.TYPE_RESULT) {
                                        return Dismissible(
                                          // Show a red background as the item is swiped away.
                                          background:
                                              Container(color: Colors.black12),
                                          key: Key(_item.serial.toString() +
                                              index.toString()),
                                          onDismissed: (direction) {
                                            setState(() {
                                              _applicationModel
                                                  .calculateModel.items
                                                  .removeAt(index);
                                              //items.removeAt(index);
                                            });
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                color: Colors.white10,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                      horizontal: SizeConfig
                                                              .blockSizeVertical *
                                                          1),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text('Sub Total',
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2.2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          '${_item.expression}',
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2.2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.white))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }

                                      return Dismissible(
                                          // Show a red background as the item is swiped away.
                                          background:
                                              Container(color: Colors.black12),
                                          key: Key(_item.serial.toString()),
                                          onDismissed: (direction) {
                                            setState(() {
                                              _applicationModel
                                                  .calculateModel.items
                                                  .removeAt(index);
                                              //items.removeAt(index);
                                            });
                                          },
                                          child: InkWell(
                                              onTap: () {
                                                _displayDialog(context, index);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .blockSizeVertical *
                                                      1,
                                                  vertical: SizeConfig
                                                          .blockSizeVertical *
                                                      .5,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text('${_item.name ?? ""}',
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                2.2,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                Colors.white)),
                                                    Text('${_item.expression}',
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                2.2,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                              )));
                                    }),
                              ),
                            )),
                      ),
                      Padding(padding: EdgeInsets.all(0)),
                      Expanded(
                        child: GestureDetector(
                            onVerticalDragStart: (DragStartDetails details) {
                              _initial = details.globalPosition.dy;
                            },
                            onVerticalDragEnd: (DragEndDetails details) {
                              _initial = 0;
                            },
                            onVerticalDragUpdate: (DragUpdateDetails details) {
                              double distance =
                                  details.globalPosition.dy - _initial;
                              setState(() {
                                _upOrDown =
                                    details.globalPosition.dy > _initial;
                              });

                              double percentageAddition = distance / 100;
                              setState(() {
                                _percentage = (_percentage + percentageAddition)
                                    .clamp(0, 100);
                              });
                              print("onPanUpdate ${_percentage}");
                              print("dragged ${details.localPosition}");

                              setState(() {
                                _animatedHeight =
                                    SizeConfig.blockSizeVertical * 5;
                                print('hhh $_animatedHeight');
                              });
                            },
                            onTap: () {
                              print("tapped");
                            },
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 30,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1,
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.blockSizeVertical *
                                                  2.5),
                                      child: new TextField(
                                        decoration:
                                            new InputDecoration.collapsed(
                                                hintText: "Start Calculating",
                                                hintStyle: TextStyle(
                                                    color: Colors.white24)),
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2.5,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                        textAlign: TextAlign.right,
                                        controller: textControllerInput,
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(new FocusNode()),
                                      )),
                                  new Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.blockSizeVertical * 2.5,
                                      ),
                                      child: TextField(
                                        decoration:
                                            new InputDecoration.collapsed(
                                          hintText: "Result",
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.white24),
                                        ),
                                        textInputAction: TextInputAction.none,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    3.5,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                        textAlign: TextAlign.right,
                                        controller: textControllerResult,
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          /*   ClipboardManager.copyToClipBoard(textControllerResult.text).then((result) {
                        Fluttertoast.showToast(
                            msg: "Value copied to clipboard!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      });*/
                                        },
                                      )),
                                ],
                              ),
                            )),
                      ),
                      /*      new Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: new IconButton(
                          icon: Icon(Icons.cancel),
                          color: Colors.deepPurpleAccent,
                          onPressed: () {
                            setState(() {
                              textControllerInput.text = "";
                              textControllerResult.text = "";
                            });
                          }))),;*/
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      AnimatedSwitcher(
                        duration: new Duration(milliseconds: 300),
                        reverseDuration: new Duration(milliseconds: 100),
                        child: _upOrDown ? Container() : keypadContainer(),
                      )
                    ],
                  )
                ],
              )));
    });
  }
}
