// spotrate_state.dart
import 'package:creative/data/models/spotratemodel/spotreate_model.dart';

abstract class SpotRateState {}

class SpotRateInitial extends SpotRateState {}

class SpotRateLoading extends SpotRateState {}

class SpotRateLoaded extends SpotRateState {
  final List<Commodity> commodities; // Directly pass the commodities list
  
  SpotRateLoaded(this.commodities);
}


class SpotRateError extends SpotRateState {
  final String error;

  SpotRateError(this.error);
}
