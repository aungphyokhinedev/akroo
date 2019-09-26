
import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/task_category.dart';
import 'package:essential/store/card_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../widgets/home_todo_card.dart';
import 'inheriteddataprovider.dart';


class TodoCards extends StatefulWidget {
  @override
  _TodoCardsState createState() => _TodoCardsState();
}

class _TodoCardsState extends State<TodoCards> with TickerProviderStateMixin {
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
      viewportFraction: 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('todo widget build');
    final _applicationModel = InheritedDataProvider.of(context).applicationModel;
    

    _disposers.add(reaction(
        (_) => _applicationModel.loginModel.isLoggedIn,
        (onboarded) =>
            onboarded ? _controller.forward() : _controller.reverse()));

    /// scroll position
    _pageController.addListener(() {
      _applicationModel.commonModel.setScrollPosition(
        _pageController.offset / _pageController.position.maxScrollExtent,
      );
      /*
      if (_todomodel.categories.isNotEmpty && _commonmodel.scrollPosition < 1) {
  
        _commonmodel.setColor(ColorTransition(
          colors: _todomodel.categoriesData
              .map((category) => CustomColors[category.color])
              .toList(),
          offset: _pageController.offset,
          maxExtent: _pageController.position.maxScrollExtent,
        ));
      }*/
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
              padding: EdgeInsets.only(top: 36.0, bottom: 28.0),
              height: MediaQuery.of(context).size.height * .72,
              child: Observer(builder: (context) {
            
                  List<CardModel> data = _applicationModel.accountCategoryModel.categories;
                  var newcat = new TaskCategory(
                        name: "",
                        color: ColorUtils.defaultColors[0].value,
                        id: "",
                        isAdd: true,
                        logo: Icons.work.codePoint);
                
                  setBackColor(index) {
                    _applicationModel.commonModel.setBackColor(data[index].accountCategory.color);
                  }

                  return PageView(
                    controller: _pageController,
                    onPageChanged: setBackColor,
                    children: data
                        .map((category) => BuildCategory(category: newcat))
                        .toList(),
                  );
             
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
  final TaskCategory category;
  BuildCategory({this.category});

  @override
  Widget build(BuildContext context) {
    print('build category');
    return TodoCard(category: category);
  }
}
