

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void customSnackbar(BuildContext context, dynamic messageOrException, Color color) {
  // Determine the message to display
  String message;
  if (messageOrException is Exception || messageOrException is Error) {
    // Handle exceptions by mapping them to user-friendly messages
    message = getFriendlyErrorMessage(messageOrException);
  } else {
    // If a plain string message is passed, use it directly
    message = messageOrException.toString();
  }

  // Show the snackbar with the user-friendly message
  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        elevation: 0,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  });
}

String getFriendlyErrorMessage(dynamic exception) {
  // Log the actual exception for debugging
  debugPrint('Exception occurred: $exception');

  // Map exceptions to user-friendly messages
  if (exception.toString().contains('SocketException')) {
    return 'Please check your internet connection.';
  } else if (exception.toString().contains('TimeoutException')) {
    return 'The request timed out. Please try again.';
  } else if (exception.toString().contains('FormatException')) {
    return 'Invalid data format. Please try again.';
  } else if (exception.toString().contains('401')) {
    return 'Unauthorized access. Please log in again.';
  } else if (exception.toString().contains('404')) {
    return 'Resource not found. Please try again later.';
  } else if (exception.toString().contains('500')) {
    return 'Server error. Please try again later.';
  } else {
    return 'An unexpected error occurred. Please try again.';
  }
}