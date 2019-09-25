// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommonModel on CommonModelBase, Store {
  final _$lngAtom = Atom(name: 'CommonModelBase.lng');

  @override
  Map<String, String> get lng {
    _$lngAtom.context.enforceReadPolicy(_$lngAtom);
    _$lngAtom.reportObserved();
    return super.lng;
  }

  @override
  set lng(Map<String, String> value) {
    _$lngAtom.context.conditionallyRunInAction(() {
      super.lng = value;
      _$lngAtom.reportChanged();
    }, _$lngAtom, name: '${_$lngAtom.name}_set');
  }

  final _$currentLngAtom = Atom(name: 'CommonModelBase.currentLng');

  @override
  String get currentLng {
    _$currentLngAtom.context.enforceReadPolicy(_$currentLngAtom);
    _$currentLngAtom.reportObserved();
    return super.currentLng;
  }

  @override
  set currentLng(String value) {
    _$currentLngAtom.context.conditionallyRunInAction(() {
      super.currentLng = value;
      _$currentLngAtom.reportChanged();
    }, _$currentLngAtom, name: '${_$currentLngAtom.name}_set');
  }

  final _$scrollPositionAtom = Atom(name: 'CommonModelBase.scrollPosition');

  @override
  double get scrollPosition {
    _$scrollPositionAtom.context.enforceReadPolicy(_$scrollPositionAtom);
    _$scrollPositionAtom.reportObserved();
    return super.scrollPosition;
  }

  @override
  set scrollPosition(double value) {
    _$scrollPositionAtom.context.conditionallyRunInAction(() {
      super.scrollPosition = value;
      _$scrollPositionAtom.reportChanged();
    }, _$scrollPositionAtom, name: '${_$scrollPositionAtom.name}_set');
  }

  final _$dateFilterAtom = Atom(name: 'CommonModelBase.dateFilter');

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

  final _$animatedColorAtom = Atom(name: 'CommonModelBase.animatedColor');

  @override
  CustomColor get animatedColor {
    _$animatedColorAtom.context.enforceReadPolicy(_$animatedColorAtom);
    _$animatedColorAtom.reportObserved();
    return super.animatedColor;
  }

  @override
  set animatedColor(CustomColor value) {
    _$animatedColorAtom.context.conditionallyRunInAction(() {
      super.animatedColor = value;
      _$animatedColorAtom.reportChanged();
    }, _$animatedColorAtom, name: '${_$animatedColorAtom.name}_set');
  }

  final _$backColorAtom = Atom(name: 'CommonModelBase.backColor');

  @override
  int get backColor {
    _$backColorAtom.context.enforceReadPolicy(_$backColorAtom);
    _$backColorAtom.reportObserved();
    return super.backColor;
  }

  @override
  set backColor(int value) {
    _$backColorAtom.context.conditionallyRunInAction(() {
      super.backColor = value;
      _$backColorAtom.reportChanged();
    }, _$backColorAtom, name: '${_$backColorAtom.name}_set');
  }

  final _$isOnBoardedAtom = Atom(name: 'CommonModelBase.isOnBoarded');

  @override
  bool get isOnBoarded {
    _$isOnBoardedAtom.context.enforceReadPolicy(_$isOnBoardedAtom);
    _$isOnBoardedAtom.reportObserved();
    return super.isOnBoarded;
  }

  @override
  set isOnBoarded(bool value) {
    _$isOnBoardedAtom.context.conditionallyRunInAction(() {
      super.isOnBoarded = value;
      _$isOnBoardedAtom.reportChanged();
    }, _$isOnBoardedAtom, name: '${_$isOnBoardedAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'CommonModelBase.isLoading');

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

  final _$observcountAtom = Atom(name: 'CommonModelBase.observcount');

  @override
  Observable<int> get observcount {
    _$observcountAtom.context.enforceReadPolicy(_$observcountAtom);
    _$observcountAtom.reportObserved();
    return super.observcount;
  }

  @override
  set observcount(Observable<int> value) {
    _$observcountAtom.context.conditionallyRunInAction(() {
      super.observcount = value;
      _$observcountAtom.reportChanged();
    }, _$observcountAtom, name: '${_$observcountAtom.name}_set');
  }

  final _$getOnboardingDoneAsyncAction = AsyncAction('getOnboardingDone');

  @override
  Future<bool> getOnboardingDone() {
    return _$getOnboardingDoneAsyncAction.run(() => super.getOnboardingDone());
  }

  final _$setOnboardingDoneAsyncAction = AsyncAction('setOnboardingDone');

  @override
  Future<void> setOnboardingDone(bool value) {
    return _$setOnboardingDoneAsyncAction
        .run(() => super.setOnboardingDone(value));
  }

  final _$CommonModelBaseActionController =
      ActionController(name: 'CommonModelBase');

  @override
  void setDateFilter(DateTime value, int timeStampOption) {
    final _$actionInfo = _$CommonModelBaseActionController.startAction();
    try {
      return super.setDateFilter(value, timeStampOption);
    } finally {
      _$CommonModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLng(String value) {
    final _$actionInfo = _$CommonModelBaseActionController.startAction();
    try {
      return super.setLng(value);
    } finally {
      _$CommonModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setScrollPosition(double value) {
    final _$actionInfo = _$CommonModelBaseActionController.startAction();
    try {
      return super.setScrollPosition(value);
    } finally {
      _$CommonModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBackColor(int color) {
    final _$actionInfo = _$CommonModelBaseActionController.startAction();
    try {
      return super.setBackColor(color);
    } finally {
      _$CommonModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setColor(ColorTransition color) {
    final _$actionInfo = _$CommonModelBaseActionController.startAction();
    try {
      return super.setColor(color);
    } finally {
      _$CommonModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
