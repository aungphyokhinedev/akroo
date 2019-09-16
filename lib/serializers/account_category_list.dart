import 'account_category.dart';

class AccountCategoryList{
  List<AccountCategory> topCategories = [];

  AccountCategoryList({this.topCategories});

  AccountCategoryList.fromJson(List<dynamic> newsList) {
    this.topCategories = [];
    for (var i = 0; i < newsList.length; i++) {
      this.topCategories.add(new AccountCategory.fromJson(newsList[i]));
    }
  }
}