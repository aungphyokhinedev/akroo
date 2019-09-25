import 'package:essential/screens/account/detail_screen.dart';
import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/widgets/common/value_input_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'add_card_screen.dart';

class AccountCardScreen extends StatefulWidget {
  final AccountCategory accountCategory;
  final ApplicationModel applicationModel;
  AccountCardScreen({
    @required this.accountCategory,
    @required this.applicationModel,
  });

  @override
  State<StatefulWidget> createState() {
    return _AccountCardScreenState();
  }
}

class _AccountCardScreenState extends State<AccountCardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true, // default false
        swipe: true, // default true
        colorTransition: Colors.black87, // default Color.black54
        innerDrawerCallback: (a) => print(a), // return bool
        // leftOffset: 0.6, // default 0.4
        rightOffset: .7, // default 0.4
        leftAnimationType: InnerDrawerAnimation.static, // default static
        rightAnimationType: InnerDrawerAnimation.quadratic, // default static
        // at least one child is required
        rightChild: LeftMenu(
            accountCategory: widget.accountCategory,
            applicationModel: widget.applicationModel,
            onDrawerBackPressed: (){
                _innerDrawerKey.currentState.toggle(
                    // direction is optional
                    // if not set, the last direction will be used
                    direction: InnerDrawerDirection.end);
            },),
        //  rightChild: Container(),
        //  A Scaffold is generally used but you are free to use other widgets
        // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
        scaffold: Scaffold(
          body: AccountDetailScreen(
              accountCategory: widget.accountCategory,
              applicationModel: widget.applicationModel,
              onDrawerPressed: () {
                _innerDrawerKey.currentState.toggle(
                    // direction is optional
                    // if not set, the last direction will be used
                    direction: InnerDrawerDirection.end);
              }),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
typedef void Callback();
class LeftMenu extends StatelessWidget {
  final AccountCategory accountCategory;
  final ApplicationModel applicationModel;
  final Callback onDrawerBackPressed;

  LeftMenu({
    @required this.accountCategory,
    @required this.applicationModel,
    @required this.onDrawerBackPressed,
  });

  
  @override
  Widget build(BuildContext context) {
    var _nf = new NumberFormat.compact();
    return new Scaffold(
    
        body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey[200], Colors.blueGrey],
            tileMode: TileMode.repeated,
          ),
        ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child:
             Observer(builder: (context) {
                var _lng = applicationModel.commonModel.lng;
              return   Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[              
              
                
                  ListTile(
                  title:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   
                    children: <Widget>[
            
                Text(
                      applicationModel.commonModel.lng['set_new_monthly'],
                    style: TextStyle(
                    //  fontSize: 18.0,
                    height: 1.1,
                      color: Colors.white,
                     // fontWeight: FontWeight.w600,
                    ),
                  ),
                   Text(
                     applicationModel.accountModel.accountCategory.monthlyLimit > 0 ?
                   applicationModel.commonModel.lng['current_limit'] + ' ' + _nf.format(applicationModel.accountModel.accountCategory.monthlyLimit) :
                   'No limit currently, set new one.',
                    style: TextStyle(
                      fontSize: 13.0,
                    height: 1.3,
                      color: Colors.white,
                    //  fontWeight: FontWeight.w600,
                    ),
                  ),
                  ],)
                   ,
                  onTap: () {
                    
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return ValueInputDialogue(
                           title:_lng['set_monthly_limit'],
                           message: _lng['momthly_limit_desc'],
                           hint:  _lng['limit_amount'],
                           onConfirm: (value) async{
                            await applicationModel.accountCategoryModel.updateCategory(
                               AccountCategory(monthlyLimit: value,id: accountCategory.id )
                               );
                            
                            await applicationModel.accountModel.refreshCategoryId(accountCategory.id);
                            await applicationModel.accountCategoryModel.refreshCategory(
                              applicationModel.accountModel.accountCategory
                            );
                            
                             print('this is limit value ${value}');
                           },
                        );
                      },
                    );
                  },
                ),
            
                ListTile(
                  title: 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
          
                   Text(
                     applicationModel.commonModel.lng['set_new_daily'],
                    style: TextStyle(
                    //  fontSize: 18.0,
                    height: 1.1,
                      color: Colors.white,
                    //  fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    applicationModel.accountModel.accountCategory.dailyLimit > 0 ?
                    applicationModel.commonModel.lng['current_limit'] + ' ' + _nf.format(applicationModel.accountModel.accountCategory.dailyLimit):
                    'No limit currently, set new one.' ,
                    style: TextStyle(
                      fontSize: 13.0,
                    height: 1.3,
                      color: Colors.white,
                   //   fontWeight: FontWeight.w600,
                    ),
                  ),
                    ]),
                    onTap: () {
         
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return ValueInputDialogue(
                           title:_lng['set_daily_limit'],
                           message: _lng['set_daily_limit_desc'],
                           hint:  _lng['limit_amount'],
                           onConfirm: (value) async{
                            await applicationModel.accountCategoryModel.updateCategory(
                               AccountCategory(dailyLimit: value,id: accountCategory.id )
                               );
                                await applicationModel.accountModel.refreshCategoryId(accountCategory.id);
                                 await applicationModel.accountCategoryModel.refreshCategory(
                              applicationModel.accountModel.accountCategory
                            );
                             print('this is limit value ${value}');
                           },
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title:Text('Edit Card',
                  style: TextStyle(
                    height: 1.1,
                      color: Colors.white,
                   //   fontWeight: FontWeight.w600,
                    ),),
                  
                  onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCardScreen(applicationModel,true),
                      ),
                    );
                  }
                ),
                ListTile(
                  title: Text(
                    _lng['delete_card'],
                    style: TextStyle(
                     // fontSize: 18.0,
                      color: Colors.white,
                     // fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                  
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(_lng['delete_card'],
                          style:TextStyle(height:1 )),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'This is a one way street! Deleting this will remove all the transactions assigned in this card.',
                                    style:TextStyle(height:1,fontSize: 13 )),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(_lng['delete']),
                              onPressed: () async{
                               await applicationModel.accountCategoryModel
                                    .removeCategory(accountCategory.id);
                              await  applicationModel.accountCategoryModel
                                    .getCategoryList();
                              if(applicationModel.accountCategoryModel.categories != null && 
                              applicationModel.accountCategoryModel.categories.length > 0){
                                     await  applicationModel.accountCategoryModel
                                   .loadSummaryInfo(
          
                                     applicationModel.accountCategoryModel.categories[0].id, 
                                     applicationModel.accountModel.dateFilter
                                     );
                              }
                            
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(_lng['cancel']),
                              textColor: Colors.grey,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              
              ],
            );
               }),
            
            ))
            ;
  }
}




