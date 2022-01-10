part of 'cqrs_mediator.dart';

abstract class _IHandlerBase {}

/// base command handler that  will be fired when [Mediator] recieved [Command]
abstract class ICommandHandler<Command extends ICommand> extends _IHandlerBase {
  void call(Command command);
}

/// base command handler that  will be fired when [Mediator] recieved [Command]
/// This can be awaitble
abstract class IAsyncCommandHandler<Command extends IAsyncCommand>
    extends _IHandlerBase {
  Future<void> call(Command command);
}
