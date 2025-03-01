import 'dart:async';
import 'dart:convert';

import 'package:creative/data/models/newsmodel/news_model.dart';
import 'package:creative/utilities/constants/url_files/url_files.dart';

import 'package:http/http.dart' as http;

final ApiUrlEndPoints _apiUrlEndPoints = ApiUrlEndPoints();

class NewsApi {
  Future<NewsModel> fetchNews() async {
    try {
      final url = Uri.parse(
          '${_apiUrlEndPoints.baseUrl}/${_apiUrlEndPoints.getnews}/${_apiUrlEndPoints.adminId}');
      final response = await http.get(url, headers: _apiUrlEndPoints.headers);

      // Check the status code
      switch (response.statusCode) {
        case 200:
          // Success: Parse the response body
          final jsonData = jsonDecode(response.body);
          return NewsModel.fromJson(jsonData);

        case 400:
          throw Exception('Bad Request: Please check your input.');
        case 401:
          throw Exception('Unauthorized: Invalid X-Secret-Key.');
        case 403:
          throw Exception('Forbidden: Access to this resource is denied.');
        case 404:
          throw Exception('Not Found: The requested resource was not found.');
        case 500:
          throw Exception('Server Error: Something went wrong on the server.');
        default:
          throw Exception(
              'Unexpected Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      // Catch any unexpected errors (e.g., network issues)
      throw Exception('Network Error: $e');
    }
  }
}
