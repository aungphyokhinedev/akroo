import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
typedef void Callback(double value);
class ValueInputDialogue extends StatefulWidget {
  final Callback onConfirm;
  final String title;
  final String message;
  final String hint;
  ValueInputDialogue({
     @required this.title,
    @required this.message,
     @required this.hint,
    @required this.onConfirm,
  });

  @override
  State<StatefulWidget> createState() {
    return _ValueInputDialogueState();
  }
}

class _ValueInputDialogueState extends State<ValueInputDialogue>{
 double _value;
 @override
  Widget build(BuildContext context) {
return AlertDialog(
              title: Text(widget.title,
              style:TextStyle(height:1 )),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        widget.message,
                        style:TextStyle(height:1.3,fontSize: 13 )),
                        Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() => _value = double.parse(value));
                  },
                  keyboardType: TextInputType.number,
                // cursorColor: taskColor,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onConfirm(_value);

                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  textColor: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
  }
}