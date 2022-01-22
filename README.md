![CQRS-removebg-preview](https://user-images.githubusercontent.com/31937782/148718369-33d5526f-7d84-4d92-9dac-fb35736edea3.png)

[![N|cqrs_mediator](https://img.shields.io/github/v/release/mo-ah-dawood/cqrs_mediator?style=for-the-badge)](https://github.com/mo-ah-dawood/cqrs_mediator) 

![GitHub forks](https://img.shields.io/github/forks/mo-ah-dawood/cqrs_mediator?style=for-the-badge) ![GitHub Repo stars](https://img.shields.io/github/stars/mo-ah-dawood/cqrs_mediator?style=for-the-badge) ![GitHub watchers](https://img.shields.io/github/watchers/mo-ah-dawood/cqrs_mediator?style=for-the-badge) [![N|cqrs_mediator](https://img.shields.io/pub/v/cqrs_mediator.svg?style=for-the-badge)](https://pub.dev/packages/cqrs_mediator)

[x] What is [CQRS](https://docs.microsoft.com/en-us/azure/architecture/patterns/cqrs)

> As described by microsoft
> CQRS stands for Command and Query Responsibility Segregation, a pattern that separates read and update operations for a data store. Implementing CQRS in > your application can maximize its performance, scalability, and security. The flexibility created by migrating to CQRS allows a system to better evolve > over time and prevents update commands from causing merge conflicts at the domain level.

[x] What is [Mediator](https://en.wikipedia.org/wiki/Mediator_pattern)

> Mediator is a behavioral design pattern that lets you reduce chaotic dependencies between objects. The pattern restricts direct communications between the objects and forces them to collaborate only via a mediator object

[x] the idea is to merge between them and make simple way to code

> if you are comming from .net there is library called `MediatR` this one is similar to it

# How to use it

There are 2 types of commands , `ICommand` & `IQuery`

## ICommand

###  Sync

* First create your command & CommandHandler

```dart
   class MyCommand extends ICommand {}

   class CommandHandler extends ICommandHandler<MyCommand> {
     @override
     void call(MyCommand command){
         // your code here
     }
    }
```

* Then use it

```dart

void main(){
     Mediator.instance.registerHandler(()=> CommandHandler());
}

/// later in your code

TextButton(
    onPressed:(){
        Mediator.instance.run(MyCommand());
    }
)

````

###  Async

* First create your command & AsyncCommandHandler

```dart
   class MyAsyncCommand extends IAsyncCommand {}

   class MyAsyncCommandHandler extends IAsyncCommandHandler<MyAsyncCommand> {
     @override
     void call(MyCommand command){
         // your code here
     }
    }
```

* Then use it

```dart

void main(){
     Mediator.instance.registerHandler(()=> MyAsyncCommandHandler());
}

/// later in your code

TextButton(
    onPressed:(){
        Mediator.instance.run(MyAsyncCommand());
    }
)

````

[x] Note when register the same instance twice then one only be registered

```dart
  /// will called only one time
  Mediator.instance.registerHandler(()=> CommandHandler());
  Mediator.instance.registerHandler(()=> CommandHandler());
```

## IQuery

###  Sync

* First create your Query & QueryHandler

```dart
   class MyQuery extends IQuery<String> {}

   class QueryHandler extends IQueryHandler<String,MyQuery> {
     @override
     string call(MyQuery query){
        return 'Your result';
     }
    }
```

* Then use it

```dart

void main(){
     Mediator.instance.registerHandler(()=> QueryHandler());
}

/// later in your code

TextButton(
    onPressed:(){
      /// get result from the first handler
      var result=  Mediator.instance.run(MyQuery());
      print(result);

      /// get result from all handlers
      var result=  Mediator.instance.runAll(MyQuery());
      print(result);
    }
)

````

###  Async

* First create your AsyncQuery & AsyncQueryHandler

```dart
   class MyAsyncQuery extends IAsyncQuery<String> {}

   class AsyncQueryHandler extends IAsyncQueryHandler<String,MyAsyncQuery> {
     @override
     Future<string> call(MyAsyncQuery query){
        return 'Your result';
     }
    }
```

* Then use it

```dart

void main(){
     Mediator.instance.registerHandler(()=> AsyncQueryHandler());
}

/// later in your code

TextButton(
    onPressed:() async{
      /// get result from the first handler
      var result=await  Mediator.instance.run(MyQuery());
      print(result);

      /// get result from all handlers
      var result=await Future.wait( Mediator.instance.runAll(MyQuery()));
      print(result);
    }
)

````
