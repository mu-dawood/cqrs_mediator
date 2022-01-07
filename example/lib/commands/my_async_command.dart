import 'package:cqrs_mediator/cqrs_mediator.dart';

class MyAsyncCommand extends IAsyncCommand {
  final String message;

  MyAsyncCommand(this.message);
}
