import 'package:essential/utils/CustomThemes.dart';
import 'package:essential/utils/Languages.dart';
import 'package:essential/utils/MyThemes.dart';
import 'package:essential/utils/constants.dart';
import 'package:essential/widgets/gradient_background.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kf_drawer/kf_drawer.dart';

class SettingsPage extends KFDrawerContent {
   SettingsPage({
    Key key,
  });
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List _lngs = Lng().data.keys.toList();
  List _themes = MyThemes.themes.keys.toList();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownThemeItems;
  String _currentLng;
  String _currentTheme;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _dropDownThemeItems = getDropDownThemeItems();
 
  //  _currentLng = _lngs[0];
    super.initState();
  }

   List<DropdownMenuItem<String>> getDropDownThemeItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String them in _themes) {
      items.add(new DropdownMenuItem(
          value: them,
          child: new Text(them)
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String lng in _lngs) {
      items.add(new DropdownMenuItem(
          value: lng,
          child: new Text(lng)
      ));
    }
    return items;
  }




  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
     
        
    return 
    new Scaffold(
     appBar: AppBar(
            leading: new IconButton(
              padding: EdgeInsets.only(left: 0),
              icon: new Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => widget.onMenuPressed(),
            ),
            elevation: 0,
            iconTheme: CustomTheme.of(context).iconTheme,
            brightness: CustomTheme.of(context).brightness,
            backgroundColor: Colors.transparent,
           
          ),
        body:
    Stack(
      
      alignment: Alignment.topCenter, children: <Widget>[
    //   GradientBackground(
    //    color: Colors.blueGrey,
    //  ),
       SafeArea(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           
            Expanded(
              child:
                 Container(
                padding: new EdgeInsets.all(26.0),

          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Text('Settings',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title),
               new Text(Constants.version,
              style: Theme.of(context)
                                        .textTheme.body1),
               Container(height: 30,),
              new Text("Please choose your language: ",
              style:  Theme.of(context)
                                        .textTheme
                                        .subhead),
           
           
             Observer(builder: (_) { 
                _currentLng = _applicationModel.commonModel.currentLng;
               return new DropdownButton(
                value: _currentLng,
                items: _dropDownMenuItems,
                onChanged: (value){
                  _applicationModel.commonModel.setLng(value);
                    //changedDropDownItem(selectedCity);
                },
                style: Theme.of(context)
                                        .textTheme
                                        .subtitle,
              );
             }),
               Container(height: 30,),
              new Text("Please choose your theme: ",
              style:  Theme.of(context)
                                        .textTheme
                                        .subhead),
           
           
             Observer(builder: (_) { 
               _currentTheme = _applicationModel.commonModel.currentTheme;
               return new DropdownButton(
                value: _currentTheme,
                items: _dropDownThemeItems,
                onChanged: (value){
                  //
                    _applicationModel.commonModel.setTheme(value);
                    MyThemeKeys _theme = MyThemes.themes[value];
                    
                    CustomTheme.instanceOf(context).changeTheme(_theme);
                    //changedDropDownItem(selectedCity);
                },
                style: Theme.of(context)
                                        .textTheme
                                        .subtitle,
              );
             })
            ],
          )
      ),
    
              
            ),
          ],
        )),
      
     ] )
    );
    
  }

  void changedDropDownItem(String value) {
    setState(() {
      _currentLng = value;
    });
  }
}
