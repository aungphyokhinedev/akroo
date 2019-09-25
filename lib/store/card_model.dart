
import 'package:essential/serializers/account_category.dart';
import 'package:essential/serializers/summary_info.dart';
import 'package:mobx/mobx.dart';


part 'card_model.g.dart';


class CardModel = CardModelBase with _$CardModel;

abstract class CardModelBase with Store {

  @observable
  AccountCategory  accountCategory;

  @observable
  SummaryInfo  summaryInfo;

  @action
  void setSummaryInfo(SummaryInfo info){
    if(accountCategory.id == info.catId){
      summaryInfo = info;
    }
  }

  CardModelBase(AccountCategory category, SummaryInfo info) {
    accountCategory = category;
    summaryInfo = info;
  }


}

