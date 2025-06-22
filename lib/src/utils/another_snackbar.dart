import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AnotherSnackbar {
  /// Shows a custom snackbar with error styling
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 10),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: Colors.red,
      messageColor: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  /// Shows a custom snackbar with success styling
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 10),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: Colors.green, // Fixed color for success
      messageColor: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  /// Shows a custom snackbar with info styling
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 10),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: Colors.blue,
      messageColor: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  /// Shows a custom snackbar with warning styling
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 10),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: Colors.amber,
      messageColor: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }
}
