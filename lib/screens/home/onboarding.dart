import 'package:essential/store/application_model.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';


class OnBoardingScreen extends StatefulWidget {
  final ApplicationModel applicationModel;
  OnBoardingScreen({
    @required this.applicationModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen>{
  
  //making list of pages needed to pass in IntroViewsFlutter constructor.


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
     SizeConfig().init(context);
     widget.applicationModel.loginModel.signOut();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twet Chat', //title of app
      color: Colors.blueGrey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        builder: (context) =>

        SafeArea(
         
          child: Observer(builder: (context) { 
           return IntroViewsFlutter(
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
             titleTextStyle: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.5, color: Colors.white),
      bodyTextStyle: TextStyle( fontSize: SizeConfig.blockSizeVertical * 1.8,color: Colors.white),
        mainImage: Image.asset(
          'assets/images/ob01.png',
         // height: 285.0,
          width:SizeConfig.blockSizeVertical * 28,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.blueGrey,
      iconImageAssetPath: 'assets/images/ob02.png',
      body: Text(
        'Check your daily/monthly income/expense. \nPut your limits and compare easily.',
      ),
      title: Text('EASY CHECK'),
      mainImage: Image.asset(
        'assets/images/ob02.png',
        width:SizeConfig.blockSizeVertical * 25,
        alignment: Alignment.center,
      ),
          titleTextStyle: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.5, color: Colors.white),
      bodyTextStyle: TextStyle( fontSize: SizeConfig.blockSizeVertical * 1.8,color: Colors.white),
    ),
 
  ],
          onTapDoneButton: () async {
            await  widget.applicationModel.commonModel.setOnboarding(true);
          
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeVertical * 2,
          ),
        );}),
        )
         , //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

