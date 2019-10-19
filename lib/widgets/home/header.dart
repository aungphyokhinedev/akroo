import 'package:essential/utils/constants.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:flutter/material.dart';

const assetsPath = "assets/images";

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
    SizeConfig().init(context);
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    _disposers.add(reaction((_) => _applicationModel.loginModel.isLoggedIn,
        (value) => value ? _controller.reverse() : _controller.forward()));
    _applicationModel.loginModel.isLoggedIn
        ? _controller.reverse()
        : _controller.forward();

    final mainContainer = Container(
      alignment: Alignment.topCenter,
      child: SizeTransition(
        sizeFactor: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _Icon(),
             Observer(builder: (context) {

         
          double size = _applicationModel.loginModel.isLoggedIn?
          SizeConfig.blockSizeVertical *2.3: SizeConfig.blockSizeVertical * 2.5;

           return Text(
                      'TWET CHAT',
                      style: TextStyle(
                          fontSize:size,
                          height: 1,
                         // fontWeight: FontWeight.w300,
                          color: Colors.white),
                    );}),
            SizedBox(height: SizeConfig.blockSizeVertical * 2.0),
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
    
    _disposers.forEach((disposer) => disposer());
    _controller.dispose();
    super.dispose();
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
    SizeConfig().init(context);
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    _applicationModel.loginModel.isLoggedIn
        ? _controller.reverse()
        : _controller.forward();

    _disposers
        .add(reaction((_) => _applicationModel.loginModel.isLoggedIn, (value) {
      if (value) {
        setState(() {
          _visible = false;
          print(
              'profile photo set ${_applicationModel.loginModel.loginInfo.photo}');
        });
        new Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _visible = true;
          });
        });
      }
    }));
    _disposers.add(reaction((_) => _applicationModel.loginModel.isLoggedIn,
        (value) => value ? _controller.reverse() : _controller.forward()));

    _applicationModel.loginModel.isLoggedIn
        ? _controller.reverse()
        : _controller.forward();
    return ScaleTransition(
      alignment: Alignment.bottomCenter,
      scale: _animation,
      child: AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1.0),
              child: Observer(builder: (context) {
                return Container(
                  height: SizeConfig.blockSizeVertical * 13.0,
                  alignment: Alignment.bottomCenter,
                  child: !_applicationModel.loginModel.isLoggedIn
                      ? Image.asset(
                          "$assetsPath/icon.png",
                          width: SizeConfig.blockSizeVertical * 10.0,
                          colorBlendMode: BlendMode.overlay,
                        )
                      : new ClipRRect(
                          borderRadius: new BorderRadius.circular(
                              SizeConfig.blockSizeVertical * 6.5),
                          child: Image.network(
                            Constants.baseUrl +
                                '/uploads/' +
                                _applicationModel.loginModel.loginInfo.photo,
                            width: SizeConfig.blockSizeVertical * 13.0,
                          ),
                        ),
                );
              }))),
    );
  }

  @override
  void dispose() {
   
    _controller.dispose();
    _disposers.forEach((disposer) => disposer());
     super.dispose();
    
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
        (value) => value ? _controller.reverse() : _controller.forward()));
    _applicationModel.loginModel.isLoggedIn
        ? _controller.reverse()
        : _controller.forward();

    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: RaisedButton(
          color: Colors.white70,
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 32.0),
          onPressed: () async {
            bool _loggedIn = await _applicationModel.loginModel.checkLogin();
            if (!_loggedIn) {
              final facebookLogin = FacebookLogin();
              final result =
                  await facebookLogin.logInWithReadPermissions(['email']);
              switch (result.status) {
                case FacebookLoginStatus.loggedIn:
                  {
                    await _applicationModel.loginModel
                        .login(result.accessToken.token, 'facebook');
                    print(result.accessToken.token);
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
            }
          },
          child: Text(
            "FACEBOOK LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
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
   _controller.dispose();
    _disposers.forEach((disposer) => disposer());
    
     super.dispose();
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
