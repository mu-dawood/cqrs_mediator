part 'i_command.dart';
part 'i_command_handler.dart';
part 'i_query.dart';
part 'i_query_handler.dart';

typedef InstanceFactory<T extends _IHandlerBase> = T Function();

class Mediator {
  static Mediator? _instance;
  static Mediator get instance => _instance ??= Mediator();
  final Set<InstanceFactory<_IHandlerBase>> _commands =
      <InstanceFactory<_IHandlerBase>>{};

  /// Register a function that return a [handler] of type [ICommandHandler] for [Command] of type [ICommand]
  void registerCommandHandler<Command extends ICommand,
          Handler extends ICommandHandler<Command>>(
      InstanceFactory<Handler> handler) {
    var handlers = _commands.whereType<InstanceFactory<Handler>>();
    if (handlers.isEmpty) {
      _commands.add(handler);
    }
  }

  /// Register a function that return a [handler] of type [IAsyncCommandHandler] for [Command] of type [IAsyncCommand]
  void registerAsyncCommandHandler<Command extends IAsyncCommand,
          Handler extends IAsyncCommandHandler<Command>>(
      InstanceFactory<Handler> handler) {
    var handlers = _commands.whereType<InstanceFactory<Handler>>();
    if (handlers.isEmpty) {
      _commands.add(handler);
    }
  }

  /// Register a function that return a [handler] of type [IQueryHandler] for [Query] of type [IQuery]
  void registerQueryHandler<TResult, Query extends IQuery<TResult>,
          Handler extends IQueryHandler<TResult, Query>>(
      InstanceFactory<Handler> handler) {
    var handlers = _commands.whereType<InstanceFactory<Handler>>();
    if (handlers.isEmpty) {
      _commands.add(handler);
    }
  }

  /// Register a function that return a [handler] of type [IAsyncQueryHandler] for [Query] of type [IAsyncQuery]
  void registerAsyncQueryHandler<TResult, Query extends IAsyncQuery<TResult>,
          Handler extends IAsyncQueryHandler<TResult, Query>>(
      InstanceFactory<Handler> handler) {
    var handlers = _commands.whereType<InstanceFactory<Handler>>();
    if (handlers.isEmpty) {
      _commands.add(handler);
    }
    print(handlers.length);
  }

  /// call all instances of [ICommandHandler] that registered for [command]
  ///
  /// If there is no handlers registered an exception will be thrown
  void command<Command extends ICommand>(Command command) {
    var handlers =
        _commands.whereType<InstanceFactory<ICommandHandler<Command>>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register command handler before calling this function");
    }
    for (var handler in handlers) {
      handler().call(command);
    }
  }

  /// call all instances of [IAsyncCommandHandler] that registered for [command]
  ///
  /// If there is no handlers registered an exception will be thrown
  Future commandAsync<Command extends IAsyncCommand>(Command command) async {
    var handlers =
        _commands.whereType<InstanceFactory<IAsyncCommandHandler<Command>>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register command handler before calling this function");
    }
    for (var handler in handlers) {
      await handler().call(command);
    }
  }

  /// call the first instance of [IQueryHandler] that registered for [query]
  ///
  /// If there is no handlers registered an exception will be thrown
  TResult query<TResult, Query extends IQuery<TResult>>(Query query) {
    var handlers =
        _commands.whereType<InstanceFactory<IQueryHandler<TResult, Query>>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register query handler before calling this function");
    }
    return handlers.first.call().call(query);
  }

  /// call the first instance of [IAsyncQueryHandler] that registered for [query]
  ///
  /// If there is no handlers registered an exception will be thrown
  Future<TResult> queryAsync<TResult, Query extends IAsyncQuery<TResult>>(
      Query query) async {
    var handlers = _commands
        .whereType<InstanceFactory<IAsyncQueryHandler<TResult, Query>>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register query handler before calling this function");
    }
    return await handlers.first().call(query);
  }

  /// call all instance of [IQueryHandler] that registered for [query]
  ///
  /// If there is no handlers registered an exception will be thrown
  Iterable<TResult> queryAll<TResult, Query extends IQuery<TResult>>(
      Query query) {
    var handlers =
        _commands.whereType<InstanceFactory<IQueryHandler<TResult, Query>>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register query handler before calling this function");
    }
    return handlers.map((e) => e().call(query));
  }

  /// call all instance of [IAsyncQueryHandler] that registered for [query]
  ///
  /// If there is no handlers registered an exception will be thrown
  Future<Iterable<TResult>>
      queryAllAsync<TResult, Query extends IAsyncQuery<TResult>>(
          Query query) async {
    var handlers = _commands
        .whereType<InstanceFactory<IAsyncQueryHandler<TResult, Query>>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register query handler before calling this function");
    }
    return await Future.wait(handlers.map((e) => e().call(query)));
  }

  /// clear all handlers
  void clearHandlers() {
    _commands.clear();
  }

  /// remove all handlers of [T]
  void removeHandlers<T extends _IHandlerBase>() {
    _commands.removeWhere((element) => element is InstanceFactory<T>);
  }

  /// remove spacified [handler]
  void removeHandler<T extends _IHandlerBase>(InstanceFactory<T> handler) {
    _commands.remove(handler);
  }

  /// get the registered handlers of [T]
  Iterable<InstanceFactory<T>> getHandler<T extends _IHandlerBase>() {
    return _commands.whereType<InstanceFactory<T>>();
  }

  /// get lenth of registered handlers
  int get length => _commands.length;
}
