import 'package:essential/widgets/account/cards.dart';
import 'package:essential/widgets/account/date_picker.dart';

import 'package:essential/widgets/home/background.dart';
import 'package:essential/widgets/home/header.dart';
import 'package:flutter/material.dart';



class AccountHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Background(),
        Header((){
          
        }),
        DateDrawer(),
        AccountCards(),
      ],
    );
  }
}
