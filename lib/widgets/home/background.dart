

import 'package:essential/utils/color_utils.dart';
import 'package:essential/widgets/gradient_background.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


import 'package:flutter/material.dart';




const assetsPath = "assets/developers/luke_pighetti/book_reader";

class Background extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  final _commonmodel = InheritedDataProvider.of(context).applicationModel.commonModel;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Observer(
          builder: (context)  {

            return GradientBackground(color: ColorUtils.getColorFrom(id:_commonmodel.backColor) );
            
          }
            
        ),
         Observer(
          builder: (context) =>  Container(
          padding: EdgeInsets.only(bottom: 36.0),
          alignment: Alignment.bottomCenter,
          child: Text(
            "",
            style: TextStyle(fontSize: 10.0, color: Colors.white),
          ),
        )
         ),
       
      ],
    );
  }
}
