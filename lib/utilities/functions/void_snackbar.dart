import 'package:creative/presentation/widgets/custome_snackbar.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, dynamic messageOrException,
    {Color backgroundColor = Colors.red}) { String message;
  if (messageOrException is Exception || messageOrException is Error) {
    // Handle exceptions by mapping them to user-friendly messages
    message = getFriendlyErrorMessage(messageOrException);
  } else {
    // If a plain string message is passed, use it directly
    message = messageOrException.toString();
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Add horizontal padding
        child: Text(
          message,
          style: TextStyle(color: Colors.white), // Customize text color
        ),
      ),
      backgroundColor: backgroundColor, 
      duration: Duration(seconds: 2), 
      behavior: SnackBarBehavior
          .floating, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
    ),
  );
}