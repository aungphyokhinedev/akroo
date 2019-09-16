import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/date_filter.dart';

import 'package:essential/store/application_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../inheriteddataprovider.dart';
import 'card.dart';

class AccountCards extends StatefulWidget {
  @override
  _AccountCardsState createState() => _AccountCardsState();
}

class _AccountCardsState extends State<AccountCards>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  PageController _pageController;

  final List<ReactionDisposer> _disposers = [];

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

    _pageController = PageController(
      viewportFraction: 0.8,
    );
     
  }

    
    

  refreshCategory(ApplicationModel applicationModel, AccountCategory category) {
    applicationModel.accountModel.setCategory(category);
  //  DateFilter dateFilter = applicationModel.commonModel.dateFilter;
    applicationModel.accountModel.setDateFilter(applicationModel.commonModel.dateFilter);
    applicationModel.accountModel.loadSummaryInfo();
  }

  @override
  Widget build(BuildContext context) {
    

    print('todo widget build');
    final _applicationModel =
        InheritedDataProvider.of(context).applicationModel;
    
    _disposers.add(reaction((_) => _applicationModel.commonModel.dateFilter,
        (msg) {
          refreshCategory(_applicationModel,_applicationModel.accountModel.accountCategory);
        }));
       
    _disposers.add(reaction(
        (_) => _applicationModel.loginModel.isLoggedIn,
        (onboarded) =>
            onboarded ? _controller.forward() : _controller.reverse()));
     _applicationModel.loginModel.isLoggedIn? _controller.forward() : _controller.reverse();
    /// scroll position
    _pageController.addListener(() {
      _applicationModel.commonModel.setScrollPosition(
        _pageController.offset / _pageController.position.maxScrollExtent,
      );
    });

    return Container(
      alignment: Alignment.bottomRight,
      child: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1.0,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 100.0),
              height: MediaQuery.of(context).size.height * .70,
              child: Observer(builder: (context) {
                if (_applicationModel.accountCategoryModel.categories == null ||_applicationModel.accountCategoryModel.categories.status ==
                    FutureStatus.pending) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (_applicationModel.accountCategoryModel.categories.status ==
                    FutureStatus.fulfilled) {

                      print('fufilled');
                  List<AccountCategory> data =
                      _applicationModel.accountCategoryModel.categories.result;

                   //adding add new card 
                  if (data.where((d) => d.isAdd).length == 0) {
                    data.add(new AccountCategory(
                        name: "",
                        color: ColorUtils.defaultColors[0].value,
                        id: "",
                        isAdd: true,
                        logo: Icons.work.codePoint));
                  }
    
                  if (_applicationModel.accountModel.accountCategory == null){
                    refreshCategory(_applicationModel, data[0]);
                  }

                 

                  onPagechange(index) {
                     refreshCategory(_applicationModel, data[index]);
                    _applicationModel.commonModel
                        .setBackColor(data[index].color);
         
                  }

                  return PageView(
                    controller: _pageController,
                    onPageChanged: onPagechange,
                    children: data
                        .map((category) => BuildCategory(
                              category: category,
                              applicationModel: _applicationModel,
                            ))
                        .toList(),
                  );
                } else {
                  return Center(
                    child: Text('Error'),
                  );
                }
              })),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((disposer) => disposer());
    _controller.dispose();
    _pageController.dispose();
  }
}

class BuildCategory extends StatelessWidget {
  final AccountCategory category;
  final ApplicationModel applicationModel;
  BuildCategory({this.category, this.applicationModel});

  @override
  Widget build(BuildContext context) {
    print('build cards');
    return AccountCard(
      category: category,
      applicationModel: applicationModel,
    );
  }
}


