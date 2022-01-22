part of 'cqrs_mediator.dart';

/// the base class for any command or query
abstract class _ICommand<TResult> {}

/// command that return  nothing
abstract class ICommand extends _ICommand<void> {}

/// command that return  future and can be awaitble
abstract class IAsyncCommand extends _ICommand<Future> {}

/// command that return [TResult]
abstract class IQuery<TResult> extends _ICommand<TResult> {}

/// command that return [Future] of [TResult]
abstract class IAsyncQuery<TResult> extends _ICommand<Future<TResult>> {}
