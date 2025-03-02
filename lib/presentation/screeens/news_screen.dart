import 'package:creative/data/models/newsmodel/news_model.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_bloc.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_event.dart';
import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_state.dart';
import 'package:creative/presentation/widgets/CustomeAppbar.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:creative/utilities/functions/new_time_format.dart';
import 'package:creative/utilities/functions/void_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchnewsBloc>().add(OnFetchNewsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
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
            return SafeArea(
              child: Column(
                children: [
                  Customappbar(text: 'Daily News',),
                  Divider(
                    thickness: 0.5,
                    color: grey,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: newsItems.length,
                      itemBuilder: (context, index) {
                        final news = newsItems[index];
                        return CustomNewsCard(news: news);
                      },
                    ),
                  ),
                ],
              ),
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

class CustomNewsCard extends StatelessWidget {  final NewsItem news;
  const CustomNewsCard({
    super.key,
    required this.news,
  });



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber[700]!, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black87,
              Colors.grey[900]!,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.amber[300],
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 2,
                width: 40,
                color: Colors.amber[700],
                margin: const EdgeInsets.only(bottom: 8),
              ),
              Text(
                news.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.yellow[100],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.amber[200],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Published: ${formatNewstime(news.createdAt.toString())}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.amber[200],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}