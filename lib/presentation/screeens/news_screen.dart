import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_bloc.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_event.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_state.dart';
import 'package:creative/utilities/functions/void_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the BLoC event to fetch news automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchnewsBloc>().add(OnFetchNewsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<FetchnewsBloc, FetchnewsState>(
        listener: (context, state) {
          if (state is FetchNewsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchNewsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FetchNewsSuccessState) {
            final newsItems = state.newsModel.newsData.newsItems;
            if (newsItems.isEmpty) {
              return Center(child: Text('No news available'));
            }
            return ListView.builder(
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                final news = newsItems[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          news.description,
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Published: ${news.createdAt.day}/${news.createdAt.month}/${news.createdAt.year}',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is FetchNewsErrorState) {
            return Center(child: Text('Failed to load news'));
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}