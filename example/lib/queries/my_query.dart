import 'package:cqrs_mediator/cqrs_mediator.dart';

class MyQuery extends IQuery<String> {
  final String userName;
  MyQuery(this.userName);
}
