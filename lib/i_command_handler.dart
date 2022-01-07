part of 'cqrs_mediator.dart';

abstract class _IHandlerBase {}

abstract class ICommandHandler<Command extends ICommand> extends _IHandlerBase {
  void call(Command command);
}

abstract class IAsyncCommandHandler<Command extends IAsyncCommand> extends _IHandlerBase {
  Future<void> call(Command command);
}
