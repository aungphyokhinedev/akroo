import 'package:essential/store/account_model.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/store/common_model.dart';
import 'package:essential/store/todo_model.dart';
import 'package:flutter/cupertino.dart';

class InheritedDataProvider extends InheritedWidget {
final ApplicationModel applicationModel;
InheritedDataProvider({
  Widget child,
  this.applicationModel,
}) : super(child: child);
@override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

static InheritedDataProvider of(BuildContext context) => context.inheritFromWidgetOfExactType(InheritedDataProvider);
}