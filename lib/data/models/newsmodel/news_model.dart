

class NewsModel {
  final bool success;
  final NewsData newsData; 
  final String message;

  NewsModel({
    required this.success,
    required this.newsData,
    required this.message,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      success: json['success'] as bool,
      newsData: NewsData.fromJson(json['news'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }
}

class NewsData {
  final String id;
  final List<NewsItem> newsItems; 
  final String createdBy;
  final int version;

  NewsData({
    required this.id,
    required this.newsItems,
    required this.createdBy,
    required this.version,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      id: json['_id'] as String,
      newsItems: (json['news'] as List<dynamic>)
          .map((item) => NewsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as String,
      version: json['__v'] as int,
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String id;
  final DateTime createdAt;

  NewsItem({
    required this.title,
    required this.description,
    required this.id,
    required this.createdAt,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] as String,
      description: json['description'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}