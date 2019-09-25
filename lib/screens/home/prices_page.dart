import 'package:essential/store/price_list_model.dart';
import 'package:essential/utils/buildin_transformers.dart';
import 'package:essential/widgets/date_picker/calendar_date_picker.dart';
import 'package:essential/widgets/date_picker/date_picker.dart';
import 'package:essential/widgets/gradient_background.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class PricesPage extends KFDrawerContent {
  @override
  _PricesPageState createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  List<Color> list = [Colors.yellow, Colors.green, Colors.blue];
  @override
  Widget build(BuildContext context) {
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    _applicationModel.priceListModel.getData();
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
       GradientBackground(
        color: Colors.blueGrey,
      ),
      SafeArea(
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
                child: Observer(builder: (context) {
                var data = _applicationModel.priceListModel.mmData;
                 if(data == null || data.items == null || data.items.length == 0) {
                   return Container();
                 }
                return  new TransformerPageView(
loop: true,
transformer: new ZoomInPageTransformer(),
itemBuilder: (BuildContext context, int index) {
  return new Container(
   // color: Colors.white,
    child: new Center(
      child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0.0),
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //  TodoBadge(
                              //    color: _color,
                              //   codePoint: widget.taskCategory.logo,
                              //   id: widget.taskCategory.id,
                              // ),
                              Spacer(
                                flex: 1,
                              ),
                           
                              Container(
                                child: Text(data.items[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(color: Colors.white)),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  '${data.items[index].unit} (${data.items[index].values[0].date})',
                                  // "${model.getTotalTodosFrom(_task)} Task",
                                  style: TextStyle(color: Colors.white)
                                ),
                              ),
                             
                              // SparkGraph(expense: expense, income: income,)
                              //
                            ],
                          ),
                        ),  
                     
                        Container(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: ListView.builder(
                              //controller: _scrollController,
                              itemBuilder: (BuildContext context, int childindex) {
                                var item = data.items[index].values[childindex];
                                var unit = data.items[index].unit;
                                return new
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                  child: Column(
                                      
                                      children: <Widget>[
Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                         new Text(
                                            item.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                       
                                               color: Colors.white,
                                               fontWeight: FontWeight.w500
                                           ),),
                                       
                                        ],
                                      ),
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                         
                                          //Text(unit),
                                          
                                                new Flexible(
                                              fit: FlexFit.loose,
                                              child: 
                                              item.rate > 0?
                                              
                                              Text(
                                                item.rate.toString() ,
                                                 style: TextStyle(
                                               color: Colors.yellow,
                                               height: 1.3
                                           ),
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              ):
                                              Column(children: <Widget>[
                                                Text(
                                                 '' + item.rate1.toString() + ' (' + item.type1 + ')' +
                                                ' '  + item.rate2.toString() +' (' + item.type2 + ')' ,
                                                 style: TextStyle(
                                               color: Colors.yellow,
                                               height: 1.3
                                           ),
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              ),
                                             
                                              ],)

                                              
                                              ),
                                               Text(
                                                '' ,
                                                 style: TextStyle(
                                               color: Colors.white
                                           ),
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              ),
                                        ],
                                      ),
                                      ],

                                     
                                    ),
                                )
                                 ;
                              },
                              itemCount: data.items[index].values.length,
                            ),
                          ),
                        ),
                      ]),
    ),
  );
},
itemCount: data.items.length);
                }),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
