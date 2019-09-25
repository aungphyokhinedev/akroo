// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_category_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountCategoryModel on AccountCategoryModelBase, Store {
  final _$categoriesAtom = Atom(name: 'AccountCategoryModelBase.categories');

  @override
  ObservableList<AccountCategory> get categories {
    _$categoriesAtom.context.enforceReadPolicy(_$categoriesAtom);
    _$categoriesAtom.reportObserved();
    return super.categories;
  }

  @override
  set categories(ObservableList<AccountCategory> value) {
    _$categoriesAtom.context.conditionallyRunInAction(() {
      super.categories = value;
      _$categoriesAtom.reportChanged();
    }, _$categoriesAtom, name: '${_$categoriesAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'AccountCategoryModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$summaryInfoAtom = Atom(name: 'AccountCategoryModelBase.summaryInfo');

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

  final _$getCategoryListAsyncAction = AsyncAction('getCategoryList');

  @override
  Future<void> getCategoryList() {
    return _$getCategoryListAsyncAction.run(() => super.getCategoryList());
  }

  final _$addCategoryAsyncAction = AsyncAction('addCategory');

  @override
  Future addCategory(AccountCategory newcategory) {
    return _$addCategoryAsyncAction.run(() => super.addCategory(newcategory));
  }

  final _$updateCategoryAsyncAction = AsyncAction('updateCategory');

  @override
  Future updateCategory(AccountCategory updateCategory) {
    return _$updateCategoryAsyncAction
        .run(() => super.updateCategory(updateCategory));
  }

  final _$removeCategoryAsyncAction = AsyncAction('removeCategory');

  @override
  Future removeCategory(String id) {
    return _$removeCategoryAsyncAction.run(() => super.removeCategory(id));
  }

  final _$AccountCategoryModelBaseActionController =
      ActionController(name: 'AccountCategoryModelBase');

  @override
  dynamic loadSummaryInfo(String catId, DateFilter dateFilter) {
    final _$actionInfo =
        _$AccountCategoryModelBaseActionController.startAction();
    try {
      return super.loadSummaryInfo(catId, dateFilter);
    } finally {
      _$AccountCategoryModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refreshCategory(AccountCategory updatedValue) {
    final _$actionInfo =
        _$AccountCategoryModelBaseActionController.startAction();
    try {
      return super.refreshCategory(updatedValue);
    } finally {
      _$AccountCategoryModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
