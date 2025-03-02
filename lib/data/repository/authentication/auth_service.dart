import 'package:creative/data/models/userModel/authentication_model.dart';
import 'package:creative/data/models/profile/profile_model.dart';
import 'package:creative/utilities/constants/url_files/url_files.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:creative/utilities/constants/url_files/url_files.dart';

class AuthService {
  final ApiUrlEndPoints apiUrlEndPoints = ApiUrlEndPoints();

  Future<void> login(UserAuthenticationModel userModel) async {
    try {
      final uri = Uri.parse(
          '${apiUrlEndPoints.baseUrl}/${apiUrlEndPoints.login}/${apiUrlEndPoints.adminId}');

      final response = await http.post(
        uri,
        headers: apiUrlEndPoints.headers,
        body: jsonEncode(userModel.toJson()),
      );

      switch (response.statusCode) {
        case 200:
          // Handle successful login
          print('Login successful: ${response.body}');
          // You can parse the response body if needed
          break;
        case 401:
          // Handle unauthorized error
          print('Unauthorized: ${response.body}');
          break;
        case 400:
          // Handle bad request error
          print('Bad request: ${response.body}');
          break;
        default:
          // Handle other errors
          print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('An error occurred: $e');
    }
  }

  Future<void> updatePassword(UserAuthenticationModel userModel) async {
    try {
      final uri = Uri.parse(
          '${apiUrlEndPoints.baseUrl}/${apiUrlEndPoints.forgotpassowrd}/${apiUrlEndPoints.adminId}');
      // Create a map for the request body
   
      final response = await http.put(uri,
          headers: apiUrlEndPoints.headers, body: jsonEncode(userModel));

      switch (response.statusCode) {
        case 200:
          // Handle successful password update
          print('Password updated successfully: ${response.body}');
          break;
        case 400:
          // Handle bad request error
          print('Bad request: ${response.body}');
          break;
        case 401:
          // Handle unauthorized error
          print('Unauthorized: ${response.body}');
          break;
        default:
          // Handle other errors
          print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('An error occurred: $e');
    }
  }
}
