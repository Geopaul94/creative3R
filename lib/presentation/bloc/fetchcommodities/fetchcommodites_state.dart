// FetchCommoditiesState.dart
part of 'fetchcommodites_bloc.dart';

@immutable
abstract class FetchCommoditiesState {}

class FetchCommoditiesInitial extends FetchCommoditiesState {}

class FetchCommoditiesLoadingState extends FetchCommoditiesState {}

class FetchCommoditiesErrorState extends FetchCommoditiesState {
  final String error;

  FetchCommoditiesErrorState({required this.error});
}class FetchCommoditiesSuccessState extends FetchCommoditiesState {
  final List<String> commodities; // Expecting a list of commodity names

  FetchCommoditiesSuccessState({required this.commodities});
}
