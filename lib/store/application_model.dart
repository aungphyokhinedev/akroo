import 'package:essential/store/account_model.dart';

import 'package:essential/store/common_model.dart';
import 'package:essential/store/todo_model.dart';

import 'account_category_model.dart';
import 'login_model.dart';

class ApplicationModel {
  AccountModel accountModel;
  AccountCategoryModel accountCategoryModel;
  CommonModel commonModel;
  ToDoModel toDoModel;
  LoginModel loginModel;

  ApplicationModel(this.accountModel,this.accountCategoryModel,this.commonModel, this.toDoModel, this.loginModel);
}