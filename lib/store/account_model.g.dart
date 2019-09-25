// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountModel on AccountModelBase, Store {
  final _$accountCategoryAtom = Atom(name: 'AccountModelBase.accountCategory');

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

  final _$dateFilterDurationTypeAtom =
      Atom(name: 'AccountModelBase.dateFilterDurationType');

  @override
  int get dateFilterDurationType {
    _$dateFilterDurationTypeAtom.context
        .enforceReadPolicy(_$dateFilterDurationTypeAtom);
    _$dateFilterDurationTypeAtom.reportObserved();
    return super.dateFilterDurationType;
  }

  @override
  set dateFilterDurationType(int value) {
    _$dateFilterDurationTypeAtom.context.conditionallyRunInAction(() {
      super.dateFilterDurationType = value;
      _$dateFilterDurationTypeAtom.reportChanged();
    }, _$dateFilterDurationTypeAtom,
        name: '${_$dateFilterDurationTypeAtom.name}_set');
  }

  final _$dateFilterAtom = Atom(name: 'AccountModelBase.dateFilter');

  @override
  DateFilter get dateFilter {
    _$dateFilterAtom.context.enforceReadPolicy(_$dateFilterAtom);
    _$dateFilterAtom.reportObserved();
    return super.dateFilter;
  }

  @override
  set dateFilter(DateFilter value) {
    _$dateFilterAtom.context.conditionallyRunInAction(() {
      super.dateFilter = value;
      _$dateFilterAtom.reportChanged();
    }, _$dateFilterAtom, name: '${_$dateFilterAtom.name}_set');
  }

  final _$transactionsAtom = Atom(name: 'AccountModelBase.transactions');

  @override
  ObservableFuture<Tuple2<AccountTransactionList, Pagination>>
      get transactions {
    _$transactionsAtom.context.enforceReadPolicy(_$transactionsAtom);
    _$transactionsAtom.reportObserved();
    return super.transactions;
  }

  @override
  set transactions(
      ObservableFuture<Tuple2<AccountTransactionList, Pagination>> value) {
    _$transactionsAtom.context.conditionallyRunInAction(() {
      super.transactions = value;
      _$transactionsAtom.reportChanged();
    }, _$transactionsAtom, name: '${_$transactionsAtom.name}_set');
  }

  final _$itemsAtom = Atom(name: 'AccountModelBase.items');

  @override
  ObservableList<AccountTransaction> get items {
    _$itemsAtom.context.enforceReadPolicy(_$itemsAtom);
    _$itemsAtom.reportObserved();
    return super.items;
  }

  @override
  set items(ObservableList<AccountTransaction> value) {
    _$itemsAtom.context.conditionallyRunInAction(() {
      super.items = value;
      _$itemsAtom.reportChanged();
    }, _$itemsAtom, name: '${_$itemsAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'AccountModelBase.isLoading');

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

  final _$paginationAtom = Atom(name: 'AccountModelBase.pagination');

  @override
  Pagination get pagination {
    _$paginationAtom.context.enforceReadPolicy(_$paginationAtom);
    _$paginationAtom.reportObserved();
    return super.pagination;
  }

  @override
  set pagination(Pagination value) {
    _$paginationAtom.context.conditionallyRunInAction(() {
      super.pagination = value;
      _$paginationAtom.reportChanged();
    }, _$paginationAtom, name: '${_$paginationAtom.name}_set');
  }

  final _$loadTransactionsAsyncAction = AsyncAction('loadTransactions');

  @override
  Future<void> loadTransactions(String catId) {
    return _$loadTransactionsAsyncAction
        .run(() => super.loadTransactions(catId));
  }

  final _$refreshCategoryIdAsyncAction = AsyncAction('refreshCategoryId');

  @override
  Future<void> refreshCategoryId(String catId) {
    return _$refreshCategoryIdAsyncAction
        .run(() => super.refreshCategoryId(catId));
  }

  final _$AccountModelBaseActionController =
      ActionController(name: 'AccountModelBase');

  @override
  dynamic setCategory(AccountCategory category) {
    final _$actionInfo = _$AccountModelBaseActionController.startAction();
    try {
      return super.setCategory(category);
    } finally {
      _$AccountModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDateFilter(DateFilter date) {
    final _$actionInfo = _$AccountModelBaseActionController.startAction();
    try {
      return super.setDateFilter(date);
    } finally {
      _$AccountModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refresh() {
    final _$actionInfo = _$AccountModelBaseActionController.startAction();
    try {
      return super.refresh();
    } finally {
      _$AccountModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic next() {
    final _$actionInfo = _$AccountModelBaseActionController.startAction();
    try {
      return super.next();
    } finally {
      _$AccountModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<AccountTransaction> addTransaction(AccountTransaction transaction) {
    final _$actionInfo = _$AccountModelBaseActionController.startAction();
    try {
      return super.addTransaction(transaction);
    } finally {
      _$AccountModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<AccountTransactionList> removeTransaction(String id) {
    final _$actionInfo = _$AccountModelBaseActionController.startAction();
    try {
      return super.removeTransaction(id);
    } finally {
      _$AccountModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
