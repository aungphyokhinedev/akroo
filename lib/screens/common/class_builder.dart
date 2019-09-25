


import 'package:essential/screens/home/calendar_page.dart';
import 'package:essential/screens/home/main_page.dart';
import 'package:essential/screens/home/prices_page.dart';
import 'package:essential/screens/home/settings_page.dart';


typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<MainPage>(() => MainPage());
    register<CalendarPage>(() => CalendarPage());
    register<PricesPage>(() => PricesPage());
    register<SettingsPage>(() => SettingsPage());

  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}