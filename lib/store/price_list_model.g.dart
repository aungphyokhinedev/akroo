// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_list_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PriceListModel on PriceListModelBase, Store {
  final _$mmDataAtom = Atom(name: 'PriceListModelBase.mmData');

  @override
  PriceGroupList get mmData {
    _$mmDataAtom.context.enforceReadPolicy(_$mmDataAtom);
    _$mmDataAtom.reportObserved();
    return super.mmData;
  }

  @override
  set mmData(PriceGroupList value) {
    _$mmDataAtom.context.conditionallyRunInAction(() {
      super.mmData = value;
      _$mmDataAtom.reportChanged();
    }, _$mmDataAtom, name: '${_$mmDataAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'PriceListModelBase.isLoading');

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

  final _$getDataAsyncAction = AsyncAction('getData');

  @override
  Future<void> getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }
}
