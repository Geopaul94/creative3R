import 'package:creative/data/models/newsmodel/news_model.dart';

sealed class FetchnewsState {}

final class FetchnewsInitial extends FetchnewsState {}

class FetchNewsLoadingState extends FetchnewsState {}

class FetchNewsErrorState extends FetchnewsState {
  final String error;
  FetchNewsErrorState(this.error);
}

class FetchNewsSuccessState extends FetchnewsState {
  final NewsModel newsModel;
  FetchNewsSuccessState(this.newsModel);
}
