
import 'package:creative/presentation/screeens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

 void handleSignOut(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.amber[700]!, width: 1),
            ),
            title: Text(
              'Confirm Sign Out',
              style: TextStyle(
                color: Colors.amber[300],
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to sign out?',
              style: TextStyle(
                color: Colors.amber[100],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  // Add your sign-out logic here
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.amber[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
