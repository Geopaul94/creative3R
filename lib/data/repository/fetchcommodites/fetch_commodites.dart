import 'dart:async';
import 'dart:convert';

import 'package:creative/data/models/commodies.dart';
import 'package:creative/data/models/newsmodel/news_model.dart';

import 'package:creative/utilities/constants/url_files/url_files.dart';

import 'package:http/http.dart' as http;

final ApiUrlEndPoints _apiUrlEndPoints = ApiUrlEndPoints();

Future<List<String>> fetchCommodities() async {
  try {
    final url = Uri.parse(
        '${_apiUrlEndPoints.baseUrl}/${_apiUrlEndPoints.getcommodities}/${_apiUrlEndPoints.adminId}');
    final response = await http.get(url, headers: _apiUrlEndPoints.headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['commodities'];
      return List<String>.from(data);
    } else {
      throw Exception('Failed to load commodities');
    }
  } catch (e) {
    throw Exception('Failed to load commodities: $e');
  }
}
