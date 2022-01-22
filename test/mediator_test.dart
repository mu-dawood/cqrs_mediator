import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:test/test.dart';

typedef ValueChanged<T> = Function(T v);

class Command1 extends ICommand {}

class Command2 extends ICommand {}

class CommandAsync extends IAsyncCommand {}

class Query extends IQuery<String> {}

class QueryAsync extends IAsyncQuery<String> {}

class CommandHandler1 extends ICommandHandler<ICommand> {
  @override
  void call(ICommand command) {}
}

class CommandHandler2 extends ICommandHandler<ICommand> {
  @override
  void call(ICommand command) {}
}

class AsyncCommandHandler extends IAsyncCommandHandler<CommandAsync> {
  @override
  Future<void> call(CommandAsync command) async {}
}

class QueryHandler extends IQueryHandler<String, Query> {
  @override
  String call(Query query) => "";
}

class AsyncQueryHandler extends IAsyncQueryHandler<String, QueryAsync> {
  @override
  Future<String> call(QueryAsync query) async => "";
}

void main() {
  test('When call registerCommandHandler length must be 1', () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => CommandHandler1());
    var length = Mediator.instance.length;
    expect(length, 1);
  });

  test('When call registerAsyncCommandHandler length must be 1', () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => AsyncCommandHandler());
    var length = Mediator.instance.length;
    expect(length, 1);
  });

  test('When call registerQueryHandler length must be 1', () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => QueryHandler());
    var length = Mediator.instance.length;
    expect(length, 1);
  });

  test('When call registerAsyncQueryHandler length must be 1', () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => AsyncQueryHandler());
    var length = Mediator.instance.length;
    expect(length, 1);
  });

  test('When call clear length must be 0', () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => AsyncQueryHandler());
    Mediator.instance.registerHandler(() => QueryHandler());
    Mediator.instance.clearHandlers();
    var length = Mediator.instance.length;
    expect(length, 0);
  });

  test('When call removeHandlers length must be 1', () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => AsyncQueryHandler());
    Mediator.instance.registerHandler(() => QueryHandler());
    Mediator.instance.removeHandlers<QueryHandler>();
    var length = Mediator.instance.length;
    expect(length, 1);
  });

  test('When call removeHandler length must be 2', () async {
    fnToRemove() {
      return CommandHandler2();
    }

    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => AsyncQueryHandler());
    Mediator.instance.registerHandler(() => CommandHandler1());
    Mediator.instance.registerHandler(fnToRemove);
    var length = Mediator.instance.length;
    expect(length, 3);
    Mediator.instance.removeHandler(fnToRemove);
    length = Mediator.instance.length;
    expect(length, 2);
  });

  test('When call registerCommandHandler with same type length must be 1',
      () async {
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => CommandHandler1());
    Mediator.instance.registerHandler(() => CommandHandler1());
    var length = Mediator.instance.length;
    expect(length, 1);
  });
}
