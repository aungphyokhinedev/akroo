import 'account_transaction.dart';

class AccountTransactionList{
  List<AccountTransaction> items = [];

  AccountTransactionList({this.items});

  AccountTransactionList.fromJson(List<dynamic> newsList) {
    this.items = [];
    for (var i = 0; i < newsList.length; i++) {
      this.items.add(new AccountTransaction.fromJson(newsList[i]));
    }
  }
}