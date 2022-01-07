import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:example/commands/my_command.dart';
import 'package:flutter/foundation.dart';

class MyCommandHandler extends ICommandHandler<MyCommand> {
  @override
  void call(MyCommand command) {
    if (kDebugMode) {
      print('Print from MyCommandHandler with message ${command.message}');
    }
  }
}
