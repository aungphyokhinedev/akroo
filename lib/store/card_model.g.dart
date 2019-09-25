// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardModel on CardModelBase, Store {
  final _$accountCategoryAtom = Atom(name: 'CardModelBase.accountCategory');

  @override
  AccountCategory get accountCategory {
    _$accountCategoryAtom.context.enforceReadPolicy(_$accountCategoryAtom);
    _$accountCategoryAtom.reportObserved();
    return super.accountCategory;
  }

  @override
  set accountCategory(AccountCategory value) {
    _$accountCategoryAtom.context.conditionallyRunInAction(() {
      super.accountCategory = value;
      _$accountCategoryAtom.reportChanged();
    }, _$accountCategoryAtom, name: '${_$accountCategoryAtom.name}_set');
  }

  final _$summaryInfoAtom = Atom(name: 'CardModelBase.summaryInfo');

  @override
  SummaryInfo get summaryInfo {
    _$summaryInfoAtom.context.enforceReadPolicy(_$summaryInfoAtom);
    _$summaryInfoAtom.reportObserved();
    return super.summaryInfo;
  }

  @override
  set summaryInfo(SummaryInfo value) {
    _$summaryInfoAtom.context.conditionallyRunInAction(() {
      super.summaryInfo = value;
      _$summaryInfoAtom.reportChanged();
    }, _$summaryInfoAtom, name: '${_$summaryInfoAtom.name}_set');
  }

  final _$CardModelBaseActionController =
      ActionController(name: 'CardModelBase');

  @override
  void setSummaryInfo(SummaryInfo info) {
    final _$actionInfo = _$CardModelBaseActionController.startAction();
    try {
      return super.setSummaryInfo(info);
    } finally {
      _$CardModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
