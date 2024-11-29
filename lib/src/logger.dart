import 'dart:io';

enum Level {
  debug,
  info,
  warn,
  error,
}

abstract class Logger {
  final IOSink output;

  Logger({IOSink? output}) : output = output ?? stdout;

  void log(Level level, String message,
      {Object? error, StackTrace? stackTrace});
}

class DefaultLogger extends Logger {
  DefaultLogger({super.output});

  @override
  void log(Level level, String message,
      {Object? error, StackTrace? stackTrace}) {
    var text = "${DateTime.now().toIso8601String()} [$level]: $message";
    if (error != null) {
      text += " error: $error";
    }
    if (stackTrace != null) {
      text += " stackTrace: $stackTrace";
    }
    print(text);
  }
}
