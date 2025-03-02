// spotrate_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_event.dart';
import 'package:creative/presentation/bloc/fetchspotrate/fetchspotrate_state.dart';

import 'package:creative/data/models/spotratemodel/spotreate_model.dart';
import 'package:creative/utilities/constants/url_files/url_files.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// BLoC Class
class SpotRateBloc extends Bloc<SpotRateEvent, SpotRateState> {
  final ApiUrlEndPoints _apiUrlEndPoints = ApiUrlEndPoints();

  SpotRateBloc() : super(SpotRateInitial()) {
 on<FetchSpotRate>((event, emit) async {
  emit(SpotRateLoading());

  try {
    final url = Uri.parse(
        '${_apiUrlEndPoints.baseUrl}/${_apiUrlEndPoints.getspotrates}/${_apiUrlEndPoints.adminId}');
    final response = await http.get(url, headers: _apiUrlEndPoints.headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final spotrateInfo = SpotRate.fromJson(data);  // Extract SpotRate
      final commodities = spotrateInfo.info.commodities; // Get commodities from info
      emit(SpotRateLoaded(commodities));
    } else {
      emit(SpotRateError('Failed to load commodities'));
    }
  } catch (e) {
    emit(SpotRateError('Failed to load commodities: $e'));
  }
});

  }
}
