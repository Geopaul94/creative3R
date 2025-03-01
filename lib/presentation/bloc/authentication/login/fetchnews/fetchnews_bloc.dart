import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetchnews_event.dart';
part 'fetchnews_state.dart';

class FetchnewsBloc extends Bloc<FetchnewsEvent, FetchnewsState> {
  FetchnewsBloc() : super(FetchnewsInitial()) {
    on<FetchnewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
