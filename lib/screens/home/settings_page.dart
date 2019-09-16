import 'package:essential/utils/Languages.dart';
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
 
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentLng;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
  //  _currentLng = _lngs[0];
    super.initState();
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
     
        
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  child: Material(
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
      color: Colors.white,
      child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Please choose your language: "),
              new Container(
                padding: new EdgeInsets.all(16.0),
              ),
             Observer(builder: (_) { 
                _currentLng = _applicationModel.commonModel.currentLng;
               return new DropdownButton(
                value: _currentLng,
                items: _dropDownMenuItems,
                onChanged: (value){
                  _applicationModel.commonModel.setLng(value);
                    //changedDropDownItem(selectedCity);
                },
              );
             })
            ],
          )
      ),
    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentLng = selectedCity;
    });
  }
}
