

import 'package:essential/utils/color_utils.dart';
import 'package:essential/widgets/gradient_background.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


import 'package:flutter/material.dart';




const assetsPath = "assets/developers/luke_pighetti/book_reader";

class Background extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  final _applicationModel = InheritedDataProvider.of(context).applicationModel;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Observer(
          builder: (context)  {

            return 
            _applicationModel.loginModel.isLoggedIn?
            GradientBackground(color: ColorUtils.getColorFrom(id:_applicationModel.commonModel.backColor) ):
            Container(color: Colors.blueGrey,);
            
          }
            
        ),
        
       
      ],
    );
  }
}
