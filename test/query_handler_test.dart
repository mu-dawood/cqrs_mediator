import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:test/test.dart';

class Query1 extends IQuery<String> {}

class Query2 extends IQuery<String> {}

class QueryHandler1 extends IQueryHandler<String, Query1> {
  @override
  String call(Query1 query) {
    return "QueryHandler1 result";
  }
}

class QueryHandler2 extends IQueryHandler<String, Query1> {
  @override
  String call(Query1 query) {
    return "QueryHandler2 result";
  }
}

void main() {
  test('When send query Result must be QueryHandler1 result', () {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerQueryHandler(() => QueryHandler1());

    var result = Mediator.instance.query(query);

    expect(result, "QueryHandler1 result");
  });

  test(
      'When send query result must be QueryHandler2 result as it is the first handler',
      () {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerQueryHandler(() => QueryHandler2());
    Mediator.instance.registerQueryHandler(() => QueryHandler1());
    var result = Mediator.instance.query(query);
    expect(result, "QueryHandler2 result");
  });

  test('When send query result must contain QueryHandler2 & QueryHandler1', () {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerQueryHandler(() => QueryHandler2());
    Mediator.instance.registerQueryHandler(() => QueryHandler1());
    var result = Mediator.instance.queryAll(query);
    expect(result.elementAt(0), "QueryHandler2 result");
    expect(result.elementAt(1), "QueryHandler1 result");
  });

  test(
      'When send query2 result must throw exception as there is no registered handlers for the query 2',
      () {
    var query = Query2();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerQueryHandler(() => QueryHandler1());
    String? result;
    try {
      result = Mediator.instance.query(query);
    } catch (e) {
      expect(result, null);
    }
  });
}
