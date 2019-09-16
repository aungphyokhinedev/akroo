// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ToDoModel on ToDoModelBase, Store {
  final _$todosAtom = Atom(name: 'ToDoModelBase.todos');

  @override
  ObservableFuture<List<TaskTodo>> get todos {
    _$todosAtom.context.enforceReadPolicy(_$todosAtom);
    _$todosAtom.reportObserved();
    return super.todos;
  }

  @override
  set todos(ObservableFuture<List<TaskTodo>> value) {
    _$todosAtom.context.conditionallyRunInAction(() {
      super.todos = value;
      _$todosAtom.reportChanged();
    }, _$todosAtom, name: '${_$todosAtom.name}_set');
  }

  final _$addTaskTodoAsyncAction = AsyncAction('addTaskTodo');

  @override
  Future addTaskTodo(TaskTodo todo) {
    return _$addTaskTodoAsyncAction.run(() => super.addTaskTodo(todo));
  }

  final _$updateTaskTodoAsyncAction = AsyncAction('updateTaskTodo');

  @override
  Future updateTaskTodo(String id, dynamic body) {
    return _$updateTaskTodoAsyncAction
        .run(() => super.updateTaskTodo(id, body));
  }

  final _$removeTaskTodoAsyncAction = AsyncAction('removeTaskTodo');

  @override
  Future removeTaskTodo(String id) {
    return _$removeTaskTodoAsyncAction.run(() => super.removeTaskTodo(id));
  }

  final _$ToDoModelBaseActionController =
      ActionController(name: 'ToDoModelBase');

  @override
  dynamic updateTodo(TaskTodo todo) {
    final _$actionInfo = _$ToDoModelBaseActionController.startAction();
    try {
      return super.updateTodo(todo);
    } finally {
      _$ToDoModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getTaskTodoList(String catId) {
    final _$actionInfo = _$ToDoModelBaseActionController.startAction();
    try {
      return super.getTaskTodoList(catId);
    } finally {
      _$ToDoModelBaseActionController.endAction(_$actionInfo);
    }
  }
}
