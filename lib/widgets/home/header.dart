import 'package:essential/utils/constants.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:flutter/material.dart';

const assetsPath = "assets/developers/luke_pighetti/book_reader";

class Header extends StatefulWidget {
   final Callback onMenuPress;
   Header(this.onMenuPress);
  @override
  _HeaderState createState() => _HeaderState();
}
typedef void Callback();
class _HeaderState extends State<Header> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
 
  final List<ReactionDisposer> _disposers = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      lowerBound: 0.37, //0.37,
      upperBound: 1.0,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

  }



  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    _disposers.add(reaction(
        (_) => _applicationModel.loginModel.isLoggedIn, (value) => value?
        _controller.reverse():
         _controller.forward()
        ));
    _applicationModel.loginModel.isLoggedIn ?
        _controller.reverse():
         _controller.forward();

    final mainContainer = Container(
      alignment: Alignment.topCenter,
      child: SizeTransition(
        sizeFactor: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _Icon(),
            Observer(
                builder: (_) => Text(
              "akroo",
                      style: TextStyle(fontSize: 30.0,
                       fontWeight: FontWeight.w300,
                       color: Colors.white),
                    )),
            SizedBox(height: 38.0),
            _Button(),
          ],
        ),
      ),
    );

    return SafeArea(
      child: Stack(
        children: <Widget>[
          mainContainer,
          BackButton(widget.onMenuPress),
        ],
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

class _Icon extends StatefulWidget {
  @override
  __IconState createState() => __IconState();
}

class __IconState extends State<_Icon> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      lowerBound: 0.6,
      upperBound: 1,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
     _applicationModel.loginModel.isLoggedIn ?
        _controller.reverse():
         _controller.forward();

   _disposers.add(reaction(
     (_) => _applicationModel.loginModel.isLoggedIn, (value) {
       if(value){
         setState(() {
           _visible = false;
           print('profile photo set ${_applicationModel.loginModel.loginInfo.photo}');
           
         
          
         });
          new Future.delayed(const Duration(milliseconds: 700), (){
             setState(() {
         
             _visible = true;
              });
          });
       }
     }
   ));
    _disposers.add(reaction(
        (_) => _applicationModel.loginModel.isLoggedIn, (value)=>value?
        _controller.reverse():
         _controller.forward()
         ));
      
 _applicationModel.loginModel.isLoggedIn ?
        _controller.reverse():
         _controller.forward();
    return ScaleTransition( 
      alignment: Alignment.bottomCenter,
      scale: _animation,
      child:AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          // The green box must be a child of the AnimatedOpacity widget.
          child:  Container(
       padding: EdgeInsets.only(bottom: 16.0),
        child: Container(
          height: 100,
          child: !_applicationModel.loginModel.isLoggedIn ? Image.asset(
          "$assetsPath/logo.png",
          width: 100.0,
        ):new ClipRRect(
    borderRadius: new BorderRadius.circular(50.0),
    child: Image.network(
        Constants.baseUrl + '/uploads/' + _applicationModel.loginModel.loginInfo.photo,
        width: 100.0,
    ),
        )
        
         ,
) 
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((disposer) => disposer());
    _controller.dispose();
  }
}

class _Button extends StatefulWidget {
  @override
  __ButtonState createState() => __ButtonState();
}

class __ButtonState extends State<_Button> with TickerProviderStateMixin {
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
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  final List<ReactionDisposer> _disposers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;

 
    _disposers.add(reaction((_) => _applicationModel.loginModel.isLoggedIn,
        (value) =>value ?
        _controller.reverse():_controller.forward()
        ));
     _applicationModel.loginModel.isLoggedIn ?
        _controller.reverse():
         _controller.forward();

    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
          onPressed: () async {
            final facebookLogin = FacebookLogin();
            final result =
                await facebookLogin.logInWithReadPermissions(['email']);
            switch (result.status) {
              case FacebookLoginStatus.loggedIn:
                {
                  await _applicationModel.loginModel.login(result.accessToken.token,'facebook');
                  print(result.accessToken.token);

                  if (_applicationModel.loginModel.isLoggedIn) {
                    await _applicationModel.accountCategoryModel.getCategoryList();

                    //  _commonmodel.setBackColor(_todomodel.categoriesData[0].color);
                  }
                }

//_showLoggedInUI();
                break;
              case FacebookLoginStatus.cancelledByUser:
                // _showCancelledMessage();
                break;
              case FacebookLoginStatus.error:
                // _showErrorOnUI(result.errorMessage);
                break;
            }
          },
          child: Text(
            "START EXPLORING",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99.9),
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

class BackButton extends StatelessWidget {
  final Callback onBackPress;
  BackButton(this.onBackPress);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(18),
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.white,
      onPressed: () {
        onBackPress();
        //  Navigator.of(context).pop();
      },
    );
  }
}
