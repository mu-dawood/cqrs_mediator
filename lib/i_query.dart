part of 'cqrs_mediator.dart';

/// Query that used with [IQueryHandler]
abstract class IQuery<TResult> {}

/// Query that used with [IAsyncQueryHandler]
abstract class IAsyncQuery<TResult> {}
