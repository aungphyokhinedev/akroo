import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:intl/intl.dart';

class NumberColorText extends StatelessWidget {
  const NumberColorText({ Key key,  this.value, this.type }) : super(key: key);

  final double value;
  final int type;
  Widget getTextWidgets(BuildContext context,List<String> strings)
  {
     SizeConfig().init(context);
    var _colors = [Colors.grey,Colors.orange,Colors.red,Colors.green,Colors.indigo, Colors.purple];
    List<Widget> list = new List<Widget>();
    

    for(var i =0 ; i < strings.length; i++){

        print('i $i, colors ind ${_colors.length -i}');

        list.add(new Text(strings[i],
        style: CustomTheme.of(context).textTheme.title.copyWith(
          color: strings.length <= _colors.length ?_colors[strings.length - (i + 1)] : Colors.grey,
          fontSize: SizeConfig.blockSizeVertical * 2.3
        ),));
    }
    list.add(
      new RotationTransition(
  turns: new AlwaysStoppedAnimation(45 / 360),
  child: Icon( type == 0? Icons.arrow_upward: Icons.arrow_downward,
    color:type == 0? Colors.grey: Colors.orange,size:SizeConfig.safeBlockHorizontal * 3.5),
)
      
      );
    return new Row(children: list,crossAxisAlignment: CrossAxisAlignment.start,);
  }

  Widget build(BuildContext context) {
    NumberFormat numberFormat =
      new NumberFormat.currency(name: '', decimalDigits: 0);
    var _strno =  numberFormat.format(this.value);
      
    return getTextWidgets(context,_strno.split(","));
  }
}
