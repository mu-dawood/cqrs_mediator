part of 'cqrs_mediator.dart';

abstract class IQueryHandler<TResult, Query extends IQuery<TResult>> extends _IHandlerBase {
  TResult call(Query query);
}

abstract class IAsyncQueryHandler<TResult, Query extends IAsyncQuery<TResult>> extends _IHandlerBase {
  Future<TResult> call(Query query);
}
