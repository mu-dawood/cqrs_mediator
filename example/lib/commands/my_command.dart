import 'package:cqrs_mediator/cqrs_mediator.dart';

class MyCommand extends ICommand {
  final String message;

  MyCommand(this.message);
}
