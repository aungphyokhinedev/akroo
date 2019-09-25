import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'home.dart';

/// This is the main method of app, from here execution starts.
/// App widget class

class OnBoarding extends StatelessWidget {
  
  //making list of pages needed to pass in IntroViewsFlutter constructor.


  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    _applicationModel.loginModel.signOut();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
           [
    PageViewModel(
        pageColor: Colors.blueGrey,
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/images/ob01.png'),
        body: Text(
          'Mini account application for\n personal budget control.',
        ),
        title: Text(
          'UTILITIES',
        ),
             titleTextStyle: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3, color: Colors.white),
      bodyTextStyle: TextStyle( fontSize: SizeConfig.blockSizeVertical * 1.8,color: Colors.white),
        mainImage: Image.asset(
          'assets/images/ob01.png',
         // height: 285.0,
          width:SizeConfig.blockSizeVertical * 28,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.blueGrey,
      iconImageAssetPath: 'assets/images/onboard01.png',
      body: Text(
        'Check your daily or monthly expense. \nPlace limitation and compare easily.',
      ),
      title: Text('EASY CHECK'),
      mainImage: Image.asset(
        'assets/images/onboard01.png',
        width:SizeConfig.blockSizeVertical * 20,
        alignment: Alignment.center,
      ),
          titleTextStyle: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3, color: Colors.white),
      bodyTextStyle: TextStyle( fontSize: SizeConfig.blockSizeVertical * 1.8,color: Colors.white),
    ),
 
  ],
          onTapDoneButton: () {
            _applicationModel.commonModel.setOnboardingDone(true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeVertical * 2,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

