import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:example/queries/my_async_query.dart';

class MyAsyncQueryHandler extends IAsyncQueryHandler<String, MyAsyncQuery> {
  @override
  Future<String> call(MyAsyncQuery query) async {
    return "your searching for ${query.userName}";
  }
}
