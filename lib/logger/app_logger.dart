import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

LogLevel logLevel = LogLevel.debug;

void _log(dynamic msg, {Object? error, StackTrace? stackTrace}) {
  if (!kDebugMode) {
    return;
  }
  final message = msg.toString();
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  switch (logLevel) {
    case LogLevel.debug:
      pattern
          .allMatches(message)
          .forEach((match) => logDebug(match.group(0), error, stackTrace));
      break;
    case LogLevel.warning:
      pattern
          .allMatches(message)
          .forEach((match) => logWarning(match.group(0), error, stackTrace));
      break;
    case LogLevel.error:
      pattern
          .allMatches(message)
          .forEach((match) => logError(match.group(0), error, stackTrace));
      break;
    case LogLevel.info:
      pattern
          .allMatches(message)
          .forEach((match) => logInfo(match.group(0), error, stackTrace));
      break;
  }
}

logD(dynamic message, {Object? error, StackTrace? stackTrace}) {
  _log(message, error: error, stackTrace: stackTrace);
}

logW(dynamic message, {Object? error, StackTrace? stackTrace}) {
  _log(message, error: error, stackTrace: stackTrace);
}

logI(dynamic message, {Object? error, StackTrace? stackTrace}) {
  _log(message, error: error, stackTrace: stackTrace);
}

logE(dynamic message, {Object? error, StackTrace? stackTrace}) {
  _log(message, error: error, stackTrace: stackTrace);
}

logWidgetBuild(BuildContext context) {
  logD("Flutter building : ${context.describeElement("")}");
}
