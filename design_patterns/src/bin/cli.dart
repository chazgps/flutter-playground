import 'package:args/command_runner.dart';

import 'builder.command.dart';
import 'factory_command.dart';
import 'prototype_command.dart';
import 'singleton_command.dart';

void main(List<String> arguments) {
  var runner =
      CommandRunner("design_pattern", "Demonstrando Design Patterns em Dart")
        ..addCommand(SingletonCommand())
        ..addCommand(FactoryCommand())
        ..addCommand(BuilderCommand())
        ..addCommand(PrototypeCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
  });
}
