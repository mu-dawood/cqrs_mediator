part of 'cqrs_mediator.dart';

/// base query handler that return [TResult]
///
/// TResult must be the same as generic of [IQuery]
///
abstract class IQueryHandler<TResult, Query extends IQuery<TResult>>
    extends _IHandlerBase {
  TResult call(Query query);
}

/// base query handler that return [Future] of [TResult]
///
/// TResult must be the same as generic of [IAsyncQuery]
abstract class IAsyncQueryHandler<TResult, Query extends IAsyncQuery<TResult>>
    extends _IHandlerBase {
  Future<TResult> call(Query query);
}
