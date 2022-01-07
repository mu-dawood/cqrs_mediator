import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:example/commands/my_async_command.dart';
import 'package:flutter/foundation.dart';

class MyAsyncCommandHandler extends IAsyncCommandHandler<MyAsyncCommand> {
  @override
  Future call(MyAsyncCommand command) async {
    if (kDebugMode) {
      print('Print from MyCommandHandler with message ${command.message}');
    }
  }
}
