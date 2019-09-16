
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
//import '../screens/home/bloc.dart';
import 'package:rxdart/rxdart.dart' show Observable;

import 'inheriteddataprovider.dart';
//import '../screens/home/models.dart' show DoubleColor;


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
   /// _controller.reverse();
  }
final List<ReactionDisposer> _disposers = [];
  @override
  Widget build(BuildContext context) {
    final _applicationModel = InheritedDataProvider.of(context).applicationModel;
    _disposers.add(
    reaction((_) => _applicationModel.loginModel.isLoggedIn, (msg) => msg?_controller.forward():_controller.reverse())
  );
  
  

    return SizeTransition(
      sizeFactor: _animation,
      axisAlignment: -1.0,
      child: Container(
        
        height: MediaQuery.of(context).size.height * 0.72,
        margin: EdgeInsets.only(top: 12.0),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 12.0, spreadRadius: -4.0)
          ],
        ),
        child: Container(
          
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _TabBar(),
            //  _Progress(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((disposer) => disposer());
    _controller.dispose();
  }
}

class _Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final _commonmodel = InheritedDataProvider.of(context).applicationModel.commonModel;

    return Container(
      
      padding: EdgeInsets.only(bottom: 24.0),
      width: MediaQuery.of(context).size.width * 0.7,
      child: 
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(_commonmodel.animatedColor),
                backgroundColor: _commonmodel.animatedColor.withOpacity(0.2),
                value: _commonmodel.scrollPosition)
      
     
    );
  }
}

class _TabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final _commonmodel = InheritedDataProvider.of(context).applicationModel.commonModel;

    return DefaultTabController(
      length: 3,
      child: TabBar(
              labelStyle:
                  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              indicatorWeight: 4.0,
              indicatorPadding: EdgeInsets.all(12.0),
              indicatorColor: _commonmodel.animatedColor,
              tabs: [
                Tab(text: "TODOS"),
                Tab(text: "TRANSACTIONS"),
                Tab(text: "EVENTS"),
              ],
            )
    );
  }
}
