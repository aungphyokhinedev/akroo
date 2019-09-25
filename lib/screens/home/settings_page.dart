import 'package:essential/utils/Languages.dart';
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
     
        
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
       GradientBackground(
        color: Colors.blueGrey,
      ),
       SafeArea(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                        Icons.arrow_back_ios,
                        color: Colors.white70,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
              ],
            ),
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
                                        .title
                                        .copyWith(color: Colors.white)),
               new Text("v1.0.3",
              style: TextStyle(
                color:Colors.white
              )),
               Container(height: 30,),
              new Text("Please choose your language: ",
              style: TextStyle(
                color:Colors.white
              )),
           
           
             Observer(builder: (_) { 
                _currentLng = _applicationModel.commonModel.currentLng;
               return new DropdownButton(
                value: _currentLng,
                items: _dropDownMenuItems,
                onChanged: (value){
                  _applicationModel.commonModel.setLng(value);
                    //changedDropDownItem(selectedCity);
                },
                style: TextStyle(
                  color: Colors.black
                ),
              );
             })
            ],
          )
      ),
    
              
            ),
          ],
        )),
      
     ] );
    
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentLng = selectedCity;
    });
  }
}
