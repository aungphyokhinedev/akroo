// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginModel on LoginModelBase, Store {
  final _$isLoadingAtom = Atom(name: 'LoginModelBase.isLoading');

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

  final _$isLoggedInAtom = Atom(name: 'LoginModelBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$loginInfoAtom = Atom(name: 'LoginModelBase.loginInfo');

  @override
  LoginInfo get loginInfo {
    _$loginInfoAtom.context.enforceReadPolicy(_$loginInfoAtom);
    _$loginInfoAtom.reportObserved();
    return super.loginInfo;
  }

  @override
  set loginInfo(LoginInfo value) {
    _$loginInfoAtom.context.conditionallyRunInAction(() {
      super.loginInfo = value;
      _$loginInfoAtom.reportChanged();
    }, _$loginInfoAtom, name: '${_$loginInfoAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<void> login(String token, String provider) {
    return _$loginAsyncAction.run(() => super.login(token, provider));
  }
}
