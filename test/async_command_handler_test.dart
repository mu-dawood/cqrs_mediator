import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Command1 extends IAyncCommand {}

class Command2 extends IAyncCommand {}

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
    Mediator.instance.registerAsyncCommandHandler(CommandHandler1((r) {
      result = r;
    }));

    await Mediator.instance.commandAsync(command);

    expect(result, command);
  });

  test('When send Command1 result1 & result2 must be Command1', () async {
    var command = Command1();
    Command1? result1;
    Command1? result2;
    Mediator.instance.clearHandlers();
    Mediator.instance.registerAsyncCommandHandler(CommandHandler1((r) {
      result1 = r;
    }));
    Mediator.instance.registerAsyncCommandHandler(CommandHandler2((r) {
      result2 = r;
    }));

    await Mediator.instance.commandAsync(command);

    expect(result1, command);
    expect(result2, command);
  });

  test('When send Command2 Result must throw exception as there is no registered handlers for the command 2', () {
    var command = Command2();
    Command1? result;
    Mediator.instance.clearHandlers();
    Mediator.instance.registerAsyncCommandHandler(CommandHandler1((r) {
      result = r;
    }));

    expectLater(Mediator.instance.commandAsync(command), throwsException);
    expect(result, null);
  });
}
