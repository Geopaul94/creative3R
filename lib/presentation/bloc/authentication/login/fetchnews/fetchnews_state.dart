part of 'fetchnews_bloc.dart';

@immutable
sealed class FetchnewsState {}

final class FetchnewsInitial extends FetchnewsState {}

class FetcNewsLoadingState extends FetchnewsState {
  
}
class FetchNewsErrorState extends FetchnewsState {
  final String message;
  FetchNewsErrorState(this.message);
  
}
class FetchNewsSuccesState extends FetchnewsState {
  final List<NewsModel> news;
  FetchNewsSuccesState(this.news);
  
}