import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:example/commands/my_async_command.dart';
import 'package:example/commands/my_command.dart';
import 'package:example/handlers/async_command_handler.dart';
import 'package:example/handlers/async_query_handler.dart';
import 'package:example/handlers/command_handler.dart';
import 'package:example/handlers/query_handler.dart';
import 'package:example/queries/my_async_query.dart';
import 'package:example/queries/my_query.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  Mediator.instance.registerHandler(() => MyCommandHandler());
  Mediator.instance.registerHandler(() => MyAsyncCommandHandler());
  Mediator.instance.registerHandler(() => MyQueryHandler());
  Mediator.instance.registerHandler(() => MyAsyncQueryHandler());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Mediator.instance.run(MyCommand("Test message"));
              },
              child: const Text("Call command handler"),
            ),
            TextButton(
              onPressed: () {
                Mediator.instance.run(MyAsyncCommand("Test message"));
              },
              child: const Text("Call async command handler"),
            ),
            TextButton(
              onPressed: () {
                var res = Mediator.instance.run(MyQuery("Test message"));
                if (kDebugMode) {
                  print(res);
                }
              },
              child: const Text("Call command handler"),
            ),
            TextButton(
              onPressed: () async {
                var res =
                    await Mediator.instance.run(MyAsyncQuery("Test message"));
                if (kDebugMode) {
                  print(res);
                }
              },
              child: const Text("Call async query handler"),
            )
          ],
        ),
      ),
    );
  }
}
