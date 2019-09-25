import 'package:essential/store/price_list_model.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/date_picker/calendar_date_picker.dart';
import 'package:essential/widgets/date_picker/date_picker.dart';
import 'package:essential/widgets/gradient_background.dart';
import 'package:essential/widgets/inheriteddataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kf_drawer/kf_drawer.dart';

class CalendarPage extends KFDrawerContent {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    _applicationModel.calendarModel.getData(_currentDate);
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
                  var mmdata = _applicationModel.calendarModel.mmData;
                  var datearr = mmdata != null ? mmdata.date.split(' ') : [];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          mmdata != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                      Text(
                                          datearr[0] +
                                              '(' +
                                              datearr[datearr.length - 3] +
                                              ' ' +
                                              datearr[datearr.length - 2] +
                                              ')',
                                          style: TextStyle(
                                              height: 1.5,
                                              fontFamily: 'Tharlon',
                                              color: Colors.white,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2)),
                                      Text(
                                        mmdata.weekday +
                                            (mmdata.sabbath != ''
                                                ? ' (' + mmdata.sabbath + ') '
                                                : ''),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Tharlon',
                                            height: 1.5,
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    2),
                                      ),
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 3,
                                      ),
                                      Container(
                                        // height: 100,
                                        alignment: AlignmentDirectional.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                //  color: Colors.white10,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  datearr[datearr.length - 1],
                                                  style: TextStyle(

                                                      //    height: 1,
                                                      //  fontFamily: 'Tharlon',
                                                      color: Colors.white,
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          5),
                                                )),
                                            Container(
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                (mmdata.yatyaza != ''
                                                        ? mmdata.yatyaza + ' '
                                                        : '') +
                                                    (mmdata.pyathada != ''
                                                        ? mmdata.pyathada + ' '
                                                        : ''),
                                                style: TextStyle(
                                                    height: 1.7,
                                                    fontFamily: 'Tharlon',
                                                    color: Colors.white,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        1.8),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      Text(mmdata.nagahle,
                                          style: TextStyle(
                                              fontFamily: 'Tharlon',
                                              height: 1.7,
                                              color: Colors.yellow,
                                              fontSize:
                                                  SizeConfig.blockSizeVertical *
                                                      2)),

                                      //   mmdata.holidays != null? Text(mmdata.holidays):Container(),
                                      //  mmdata.holidays2 != null? Text(mmdata.holidays2) : Container(),
                                      //   Text(mmdata.mahabote),
                                      //   Text(mmdata.astro),
                                    ])
                              : Container(),
                          Container(
                            height: 30,
                          ),
                          CalendarDatePickerTimeline(
                            dateSize: SizeConfig.blockSizeVertical * 3,
                            daySize: SizeConfig.blockSizeVertical * 1.3,
                            monthSize: SizeConfig.blockSizeVertical * 1.3,
                            //  dateColor: Colors.white,
                            monthColor: Colors.white54,
                            dayColor: Colors.white54,
                            setDate: _currentDate,
                            startDate:
                                DateTime.now().add(new Duration(days: 350)),
                            onDateChange: (date) async {
                              // New date selected
                              setState(() {
                                _currentDate = date;
                              });
                              await _applicationModel.calendarModel
                                  .getData(date);
                              print('prices item length' +
                                  _applicationModel
                                      .priceListModel.mmData.items.length
                                      .toString());
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
