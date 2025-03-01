// Without json_serializable
class NewsModel {
  final bool success;
  final Map info;
  final String message;

  NewsModel({
    required this.success,
    required this.info,
    required this.message,
  });

  // Manual parsing
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      success: json['success'] as bool,
      info: Map.fromJson(json['Map'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  // Manual serialization
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'info': Map.toJson(),
      'message': message,
    };
  }
}