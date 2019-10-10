
import 'package:essential/screens/common/class_builder.dart';
import 'package:essential/screens/calculator/calculator_page.dart';
import 'package:essential/screens/home/prices_page.dart';
import 'package:essential/widgets/calculator/home.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'calendar_page.dart';
import 'main_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('MainPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('MAIN', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: MainPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'CALCULATOR',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.white),
          page: CalculatorPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'MARKET PRICES',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          page: PricesPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: ClassBuilder.fromString('SettingsPage'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
   final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
     return  Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
              "twet chat",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                Text("Time to save money.",
                style: TextStyle(fontSize: 14.0, color: Colors.white),)    
            ],) 
          ),
        ),
        footer:
        Observer(builder: (context) { 
          if(_applicationModel.loginModel.isLoggedIn){
return KFDrawerItem(
          text: Text(
            'SIGN OUT',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
        //    _applicationModel.commonModel.setOnboarding(null);
            _applicationModel.loginModel.signOut();
            final facebookLogin = FacebookLogin();
            facebookLogin.logOut();
          },
        );
          }
          else{
            return Container();
          }
          
        }),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey[200], Colors.blueGrey],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    
    );

  }
}
