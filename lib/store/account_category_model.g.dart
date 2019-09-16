// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_category_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountCategoryModel on AccountCategoryModelBase, Store {
  final _$categoriesAtom = Atom(name: 'AccountCategoryModelBase.categories');

  @override
  ObservableFuture<List<AccountCategory>> get categories {
    _$categoriesAtom.context.enforceReadPolicy(_$categoriesAtom);
    _$categoriesAtom.reportObserved();
    return super.categories;
  }

  @override
  set categories(ObservableFuture<List<AccountCategory>> value) {
    _$categoriesAtom.context.conditionallyRunInAction(() {
      super.categories = value;
      _$categoriesAtom.reportChanged();
    }, _$categoriesAtom, name: '${_$categoriesAtom.name}_set');
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
  dynamic getCategoryList() {
    final _$actionInfo =
        _$AccountCategoryModelBaseActionController.startAction();
    try {
      return super.getCategoryList();
    } finally {
      _$AccountCategoryModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
