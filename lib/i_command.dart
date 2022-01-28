part of 'cqrs_mediator.dart';

/// the base class for any command or query
abstract class IBaseCommand<TResult> {}

/// command that return  nothing
abstract class ICommand extends IBaseCommand<void> {}

/// command that return  future and can be awaitble
abstract class IAsyncCommand extends IBaseCommand<Future> {}

/// command that return [TResult]
abstract class IQuery<TResult> extends IBaseCommand<TResult> {}

/// command that return [Future] of [TResult]
abstract class IAsyncQuery<TResult> extends IBaseCommand<Future<TResult>> {}
