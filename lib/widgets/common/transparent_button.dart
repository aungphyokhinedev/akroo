import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TransparentButton extends StatefulWidget {

  String title;
  bool disabled;
  Function onPress;
  TransparentButton(this.title, this.disabled, this.onPress);


@override
_TransparentButtonState createState() => new _TransparentButtonState();
}

class _TransparentButtonState extends State<TransparentButton> {
  
  @override
  Widget build(BuildContext context) {
  return   InkWell(
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
         // color: selectionColor,
        ),
        child: Text(widget.title, style: TextStyle(color: Colors.white60),)
      ),
      onTap: (){
        print('press');
        widget.onPress();
      },
  );
}
}

