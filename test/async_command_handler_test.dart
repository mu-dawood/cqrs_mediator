import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:test/test.dart';

typedef ValueChanged<T> = Function(T v);

class Command1 extends IAsyncCommand {}

class Command2 extends IAsyncCommand {}

class CommandHandler1 extends IAsyncCommandHandler<Command1> {
  final ValueChanged<Command1> callback;

  CommandHandler1(this.callback);
  @override
  Future call(Command1 command) async {
    callback(command);
  }
}

class CommandHandler2 extends IAsyncCommandHandler<Command1> {
  final ValueChanged<Command1> callback;

  CommandHandler2(this.callback);
  @override
  Future call(Command1 command) async {
    callback(command);
  }
}

void main() {
  test('When send Command1 Result must be the passed command', () async {
    var command = Command1();
    Command1? result;
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => CommandHandler1((r) {
          result = r;
        }));

    await Mediator.instance.run(command);

    expect(result, command);
  });

  test('When send Command1 result1 & result2 must be Command1', () async {
    var command = Command1();
    Command1? result1;
    Command1? result2;
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => CommandHandler1((r) {
          result1 = r;
        }));

    Mediator.instance.registerHandler(() => CommandHandler2((r) {
          result2 = r;
        }));

    await Future.wait(Mediator.instance.runAll(command));

    expect(result1, command);
    expect(result2, command);
  });

  test(
      'When send Command2 Result must throw exception as there is no registered handlers for the command 2',
      () {
    var command = Command2();
    Command1? result;
    Mediator.instance.clearHandlers();
    Mediator.instance.registerHandler(() => CommandHandler1((r) {
          result = r;
        }));

    expectLater(() async => Mediator.instance.run(command), throwsException);
    expect(result, null);
  });
}
