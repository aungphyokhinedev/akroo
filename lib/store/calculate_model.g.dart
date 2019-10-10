// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalculateModel on CalculateModelBase, Store {
  final _$paginationAtom = Atom(name: 'CalculateModelBase.pagination');

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

  final _$currentGroupAtom = Atom(name: 'CalculateModelBase.currentGroup');

  @override
  CalculateGroup get currentGroup {
    _$currentGroupAtom.context.enforceReadPolicy(_$currentGroupAtom);
    _$currentGroupAtom.reportObserved();
    return super.currentGroup;
  }

  @override
  set currentGroup(CalculateGroup value) {
    _$currentGroupAtom.context.conditionallyRunInAction(() {
      super.currentGroup = value;
      _$currentGroupAtom.reportChanged();
    }, _$currentGroupAtom, name: '${_$currentGroupAtom.name}_set');
  }

  final _$grouplistsAtom = Atom(name: 'CalculateModelBase.grouplists');

  @override
  ObservableList<CalculateGroup> get grouplists {
    _$grouplistsAtom.context.enforceReadPolicy(_$grouplistsAtom);
    _$grouplistsAtom.reportObserved();
    return super.grouplists;
  }

  @override
  set grouplists(ObservableList<CalculateGroup> value) {
    _$grouplistsAtom.context.conditionallyRunInAction(() {
      super.grouplists = value;
      _$grouplistsAtom.reportChanged();
    }, _$grouplistsAtom, name: '${_$grouplistsAtom.name}_set');
  }

  final _$itemsAtom = Atom(name: 'CalculateModelBase.items');

  @override
  ObservableList<CalculateData> get items {
    _$itemsAtom.context.enforceReadPolicy(_$itemsAtom);
    _$itemsAtom.reportObserved();
    return super.items;
  }

  @override
  set items(ObservableList<CalculateData> value) {
    _$itemsAtom.context.conditionallyRunInAction(() {
      super.items = value;
      _$itemsAtom.reportChanged();
    }, _$itemsAtom, name: '${_$itemsAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'CalculateModelBase.isLoading');

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

  final _$addCaculateGroupAsyncAction = AsyncAction('addCaculateGroup');

  @override
  Future<void> addCaculateGroup(CalculateGroup data) {
    return _$addCaculateGroupAsyncAction
        .run(() => super.addCaculateGroup(data));
  }

  final _$deleteCaculateGroupAsyncAction = AsyncAction('deleteCaculateGroup');

  @override
  Future<void> deleteCaculateGroup(CalculateGroup data) {
    return _$deleteCaculateGroupAsyncAction
        .run(() => super.deleteCaculateGroup(data));
  }

  final _$loadCaculateGroupsAsyncAction = AsyncAction('loadCaculateGroups');

  @override
  Future<void> loadCaculateGroups() {
    return _$loadCaculateGroupsAsyncAction
        .run(() => super.loadCaculateGroups());
  }

  final _$CalculateModelBaseActionController =
      ActionController(name: 'CalculateModelBase');

  @override
  void addItem(CalculateData item) {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.addItem(item);
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem(int index) {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.removeItem(index);
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAll() {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.removeAll();
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateItem(int index, CalculateData item) {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.updateItem(index, item);
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentGroup(CalculateGroup data) {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.setCurrentGroup(data);
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refresh() {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.refresh();
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic next() {
    final _$actionInfo = _$CalculateModelBaseActionController.startAction();
    try {
      return super.next();
    } finally {
      _$CalculateModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
