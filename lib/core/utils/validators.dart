import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message) {
    if (kDebugMode) {
      print("🔍 [DEBUG] $message");
    }
  }

  static void error(String message, [Object? error]) {
    if (kDebugMode) {
      print("⛔ [ERROR] $message");
      if (error != null) print("🔻 $error");
    }
  }

  static void success(String message) {
    if (kDebugMode) {
      print("✅ [SUCCESS] $message");
    }
  }
}
