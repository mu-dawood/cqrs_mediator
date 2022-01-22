part of 'cqrs_mediator.dart';

abstract class _IHandlerBase {}

/// TResult must be the same as generic of [_ICommand]
///
abstract class _ICommandHandler<TResult, Command extends _ICommand<TResult>>
    extends _IHandlerBase {
  TResult call(Command command);
}

/// handler that not return any thing
abstract class ICommandHandler<Command extends ICommand>
    extends _ICommandHandler<void, Command> {}

/// handler that  return future
abstract class IAsyncCommandHandler<Command extends IAsyncCommand>
    extends _ICommandHandler<Future, Command> {}

/// handler that  return [TResult]
abstract class IQueryHandler<TResult, Query extends IQuery<TResult>>
    extends _ICommandHandler<TResult, Query> {}

/// handler that  return [TResult]
abstract class IAsyncQueryHandler<TResult, Query extends IAsyncQuery<TResult>>
    extends _ICommandHandler<Future<TResult>, Query> {}
