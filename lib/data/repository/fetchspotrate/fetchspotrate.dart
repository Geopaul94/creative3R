import 'dart:async';
import 'dart:convert';

import 'package:creative/data/models/spotratemodel/spotreate_model.dart';

import 'package:creative/utilities/constants/url_files/url_files.dart';

import 'package:http/http.dart' as http;

final ApiUrlEndPoints _apiUrlEndPoints = ApiUrlEndPoints();

Future<List<SpotRate>> fetchSpotRate() async {
  try {
    // Build the API URL
    final url = Uri.parse(
        '${_apiUrlEndPoints.baseUrl}/${_apiUrlEndPoints.getspotrates}/${_apiUrlEndPoints.adminId}');

    // Perform the HTTP GET request
    final response = await http.get(url, headers: _apiUrlEndPoints.headers);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body
      final data = json.decode(response.body)['commodities'];

      // Map the JSON data to a list of Commodity objects
      return List<SpotRate>.from(
        data.map((SpotRate) => Commodity.fromJson(SpotRate)),
      );
    } else {
      // Handle non-200 response codes
      throw Exception(
          'Failed to load commodities. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions during the API call
    throw Exception('Failed to load commodities: $e');
  }
}
