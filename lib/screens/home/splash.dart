import 'package:essential/utils/constants.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'home.dart';
import 'onboarding.dart';

/// This is the main method of app, from here execution starts.
/// App widget class

class Splash extends StatelessWidget {
  
  //making list of pages needed to pass in IntroViewsFlutter constructor.



  @override
  Widget build(BuildContext context) {
    final _applicationModel = InheritedDataProvider.of(context).applicationModel;
     SizeConfig().init(context);

    new Future.delayed(const Duration(milliseconds: 1000), (){
      _applicationModel.commonModel.initData();
    });
   
     
    return  Observer(builder: (_)  {
            if(_applicationModel.commonModel.isOnBoarded == null){
              return
              Container(
                color: Colors.blueGrey,
                child: Center(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
Image.asset(  
                          "assets/images/cybernetics.png",
                          width: SizeConfig.blockSizeVertical * 12.0,
                          colorBlendMode: BlendMode.overlay,
                        ),
                       
                ],)
                 ),)
               ;
            }

      return  _applicationModel.commonModel.isOnBoarded == true ? HomePage() : 
      OnBoardingScreen(applicationModel: _applicationModel,);

          
          
          }
      
      
       //IntroViewsFlutter
     //Builder
    ); //Material App
  }
}

