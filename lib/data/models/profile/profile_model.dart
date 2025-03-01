class ProfileModel {
  final bool success;
  final CompanyInfo info;
  final String message;

  ProfileModel({
    required this.success,
    required this.info,
    required this.message,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'] as bool,
      info: CompanyInfo.fromJson(json['info'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }
}

class CompanyInfo {
  final String id;
  final String userName;
  final String companyName;
  final String address;
  final String email;
  final String contact;  // Stored as String for phone number formatting
  final String whatsapp; // Stored as String for phone number formatting

  CompanyInfo({
    required this.id,
    required this.userName,
    required this.companyName,
    required this.address,
    required this.email,
    required this.contact,
    required this.whatsapp,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      id: json['_id'] as String,
      userName: json['userName'] as String,
      companyName: json['companyName'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      // Convert numbers to strings and add country code formatting
      contact: '+${json['contact']}',
      whatsapp: '+${json['whatsapp']}',
    );
  }
}