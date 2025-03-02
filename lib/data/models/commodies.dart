class CommoditiesResponse {
  final bool success;
  final List<String> commodities;
  final String message;

  CommoditiesResponse({
    required this.success,
    required this.commodities,
    required this.message,
  });

  // Factory method to create a CommoditiesResponse object from JSON
  factory CommoditiesResponse.fromJson(Map<String, dynamic> json) {
    return CommoditiesResponse(
      success: json['success'],
      commodities: List<String>.from(json['commodities']),
      message: json['message'],
    );
  }

  // Method to convert the CommoditiesResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'commodities': commodities,
      'message': message,
    };
  }
}
