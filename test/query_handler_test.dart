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
    Mediator.instance.registerHandler(() => QueryHandler1());

    var result = Mediator.instance.run(query);

    expect(result, "QueryHandler1 result");
  });

  test(
      'When send query result must be QueryHandler2 result as it is the first handler',
      () {
    var query = Query1();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => QueryHandler2());
    Mediator.instance.registerHandler(() => QueryHandler1());
    var result = Mediator.instance.run(query);
    expect(result, "QueryHandler2 result");
  });

  test(
      'When send query2 result must throw exception as there is no registered handlers for the query 2',
      () {
    var query = Query2();
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => QueryHandler1());
    String? result;
    try {
      result = Mediator.instance.run(query);
    } catch (e) {
      expect(result, null);
    }
  });
}
