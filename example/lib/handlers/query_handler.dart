import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:example/queries/my_query.dart';

class MyQueryHandler extends IQueryHandler<String, MyQuery> {
  @override
  String call(MyQuery query) {
    return "your searching for ${query.userName}";
  }
}
