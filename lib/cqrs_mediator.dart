part 'i_command.dart';
part 'i_command_handler.dart';

typedef _InstanceFactoryChecker<TResult, Command extends IBaseCommand<TResult>>
    = _ICommandHandler<TResult, Command> Function();

typedef InstanceFactory<T extends IBaseHandler> = T Function();

class Mediator {
  static Mediator? _instance;
  static Mediator get instance => _instance ??= Mediator();
  final Set<InstanceFactory<IBaseHandler>> _commands =
      <InstanceFactory<IBaseHandler>>{};

  /// Register a function that return a [handler] of type [ICommandHandler] for [Command] of type [IBaseCommand]
  void registerHandler<TResult, Command extends IBaseCommand<TResult>,
          Handler extends _ICommandHandler<TResult, Command>>(
      InstanceFactory<Handler> handler) {
    var handlers = _commands.whereType<InstanceFactory<Handler>>();
    if (handlers.isEmpty) {
      _commands.add(handler);
    }
  }

  /// call the first instance of [ICommandHandler] that registered for [command]
  ///
  /// If there is no handlers registered an exception will be thrown
  TResult run<TResult, Command extends IBaseCommand<TResult>>(Command command) {
    var handlers =
        _commands.whereType<_InstanceFactoryChecker<TResult, Command>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register query handler for ${command.runtimeType} before calling this function");
    }
    return handlers.first.call().call(command);
  }

  /// call all instances of [ICommandHandler] that registered for [command]
  ///
  /// If there is no handlers registered an exception will be thrown
  List<TResult> runAll<TResult, Command extends IBaseCommand<TResult>>(
      Command command) {
    var handlers =
        _commands.whereType<_InstanceFactoryChecker<TResult, Command>>();
    if (handlers.isEmpty) {
      throw Exception(
          "You must register query handler for ${command.runtimeType} before calling this function");
    }
    return handlers.map((e) => e.call().call(command)).toList();
  }

  /// clear all handlers
  void clearHandlers() {
    _commands.clear();
  }

  /// remove all handlers of [T]
  void removeHandlers<T extends IBaseHandler>() {
    _commands.removeWhere((element) => element is InstanceFactory<T>);
  }

  /// remove spacified [handler]
  void removeHandler<T extends IBaseHandler>(InstanceFactory<T> handler) {
    _commands.remove(handler);
  }

  /// get the registered handlers of [T]
  Iterable<InstanceFactory<T>> getHandler<T extends IBaseHandler>() {
    return _commands.whereType<InstanceFactory<T>>();
  }

  /// get lenth of registered handlers
  int get length => _commands.length;

  /// get the registered handlers for [Command]
  Iterable<_InstanceFactoryChecker<TResult, Command>>
      getHandlersFor<TResult, Command extends IBaseCommand<TResult>>(
          Command command) {
    return _commands.whereType<_InstanceFactoryChecker<TResult, Command>>();
  }
}
