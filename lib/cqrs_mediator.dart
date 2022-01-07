part 'i_command.dart';
part 'i_command_handler.dart';
part 'i_query.dart';
part 'i_query_handler.dart';

class Mediator {
  static Mediator? _instance;
  static Mediator get instance => _instance ??= Mediator();
  final List<_IHandlerBase> _commands = <_IHandlerBase>[];
  void registerCommandHandler<Command extends ICommand, Handler extends ICommandHandler<Command>>(Handler handler) {
    _commands.add(handler);
  }

  void registerAsyncCommandHandler<Command extends IAyncCommand, Handler extends IAsyncCommandHandler<Command>>(
      Handler handler) {
    _commands.add(handler);
  }

  void registerQueryHandler<TResult, Query extends IQuery<TResult>, Handler extends IQueryHandler<TResult, Query>>(
      Handler handler) {
    _commands.add(handler);
  }

  void registerAsyncQueryHandler<TResult, Query extends IAsyncQuery<TResult>,
      Handler extends IAsyncQueryHandler<TResult, Query>>(Handler handler) {
    _commands.add(handler);
  }

  void command<Command extends ICommand>(Command command) {
    var handlers = _commands.whereType<ICommandHandler<Command>>();
    if (handlers.isEmpty) {
      throw Exception("You must register command handler before calling this function");
    }
    for (var handler in handlers) {
      handler.call(command);
    }
  }

  Future commandAsync<Command extends IAyncCommand>(Command command) async {
    var handlers = _commands.whereType<IAsyncCommandHandler<Command>>();
    if (handlers.isEmpty) {
      throw Exception("You must register command handler before calling this function");
    }
    for (var handler in handlers) {
      await handler.call(command);
    }
  }

  TResult query<TResult, Query extends IQuery<TResult>>(Query query) {
    var handlers = _commands.whereType<IQueryHandler<TResult, Query>>();
    if (handlers.isEmpty) {
      throw Exception("You must register query handler before calling this function");
    }
    return handlers.first.call(query);
  }

  Future<TResult> queryAsync<TResult, Query extends IAsyncQuery<TResult>>(Query query) async {
    var handlers = _commands.whereType<IAsyncQueryHandler<TResult, Query>>();
    if (handlers.isEmpty) {
      throw Exception("You must register query handler before calling this function");
    }
    return await handlers.first.call(query);
  }

  Iterable<TResult> queryAll<TResult, Query extends IQuery<TResult>>(Query query) {
    var handlers = _commands.whereType<IQueryHandler<TResult, Query>>();
    if (handlers.isEmpty) {
      throw Exception("You must register query handler before calling this function");
    }
    return handlers.map((e) => e.call(query));
  }

  Future<Iterable<TResult>> queryAllAsync<TResult, Query extends IAsyncQuery<TResult>>(Query query) async {
    var handlers = _commands.whereType<IAsyncQueryHandler<TResult, Query>>();
    if (handlers.isEmpty) {
      throw Exception("You must register query handler before calling this function");
    }
    return await Future.wait(handlers.map((e) => e.call(query)));
  }

  void clearHandlers() {
    _commands.clear();
  }

  void removeHandlers<T extends _IHandlerBase>() {
    _commands.removeWhere((element) => element is T);
  }

  void removeHandler<T extends _IHandlerBase>(T handler) {
    _commands.remove(handler);
  }
}
