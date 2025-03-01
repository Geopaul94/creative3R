import 'package:bloc/bloc.dart';
import 'package:creative/data/models/newsmodel/news_model.dart';
import 'package:creative/data/repository/news/fetch_news.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_event.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_state.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


class FetchnewsBloc extends Bloc<FetchnewsEvent, FetchnewsState> {
  FetchnewsBloc() : super(FetchnewsInitial()) {
    on<OnFetchNewsEvent>(_fetchNewsEvent);
  }

  Future<void> _fetchNewsEvent(
    OnFetchNewsEvent event, Emitter<FetchnewsState> emit) async {
  emit(FetchNewsLoadingState());
  print('Fetching news...'); // Debugging line
  try {
    final NewsModel newsModel = await NewsApi().fetchNews();
    print('News fetched successfully: ${newsModel.message}'); // Debugging line
    emit(FetchNewsSuccessState(newsModel));
  } catch (e) {
    print('Error fetching news: $e'); // Debugging line
    emit(FetchNewsErrorState(e.toString()));
  }
}
}