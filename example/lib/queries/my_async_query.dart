import 'package:cqrs_mediator/cqrs_mediator.dart';

class MyAsyncQuery extends IAsyncQuery<String> {
  final String userName;

  MyAsyncQuery(this.userName);
}
