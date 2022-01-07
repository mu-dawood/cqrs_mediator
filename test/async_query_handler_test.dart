import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:flutter_test/flutter_test.dart';

class Query1 extends IAsyncQuery<String> {}

class Query2 extends IAsyncQuery<String> {}

class QueryHandler1 extends IAsyncQueryHandler<String, Query1> {
  @override
  Future<String> call(Query1 query) async {
    return "AsyncQueryHandler1 result";
  }
}

class QueryHandler2 extends IAsyncQueryHandler<String, Query1> {
  @override
  Future<String> call(Query1 query) async {
    return "AsyncQueryHandler2 result";
  }
}

void main() {
  test('When send query Result must be AsyncQueryHandler1 result', () async {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerAsyncQueryHandler(QueryHandler1());

    var result = await Mediator.instance.queryAsync(query);

    expect(result, "AsyncQueryHandler1 result");
  });

  test('When send query result must be AsyncQueryHandler2 result as it is the first handler', () async {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerAsyncQueryHandler(QueryHandler2());
    Mediator.instance.registerAsyncQueryHandler(QueryHandler1());
    var result = await Mediator.instance.queryAsync(query);
    expect(result, "AsyncQueryHandler2 result");
  });

  test('When send query result must contain AsyncQueryHandler1 & AsyncQueryHandler2', () async {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerAsyncQueryHandler(QueryHandler2());
    Mediator.instance.registerAsyncQueryHandler(QueryHandler1());
    var result = await Mediator.instance.queryAllAsync(query);
    expect(result.elementAt(0), "AsyncQueryHandler2 result");
    expect(result.elementAt(1), "AsyncQueryHandler1 result");
  });

  test('When send query2 result must throw exception as there is no registered handlers for the query 2', () {
    var query = Query2();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerAsyncQueryHandler(QueryHandler1());

    expectLater(Mediator.instance.queryAsync(query), throwsException);
  });
}
