import 'package:bloc/bloc.dart';
import 'package:creative/data/models/commodies.dart';
import 'package:creative/data/repository/fetchcommodites/fetch_commodites.dart';
import 'package:meta/meta.dart';

part 'fetchcommodites_event.dart';
part 'fetchcommodites_state.dart';

class FetchCommoditiesBloc
    extends Bloc<FetchCommoditiesEvent, FetchCommoditiesState> {
  FetchCommoditiesBloc() : super(FetchCommoditiesInitial()) {
    on<OnFetchCommoditiesEvent>(_onFetchCommoditiesEvent);
  }
  Future<void> _onFetchCommoditiesEvent(OnFetchCommoditiesEvent event,
      Emitter<FetchCommoditiesState> emit) async {
    emit(FetchCommoditiesLoadingState());
    try {
      final commodities = await fetchCommodities();
      emit(FetchCommoditiesSuccessState(commodities: commodities));
    } catch (e) {
      emit(FetchCommoditiesErrorState(error: e.toString()));
    }
  }
}
