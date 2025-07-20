import 'dart:convert';

class UserApiResponse {
  final String message;
  final bool status;
  final UserModel data;

  UserApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      message: json['message'],
      status: json['status'],
      data: UserModel.fromJson(json['data']),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String role;
  final String image;
  final bool isRemoved;
  final String status;
  final String userId;
  final String createdBy;
  final String associatedSociety;
  final List<String> emergencyContacts;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final AdditionalDetails additionalDetails;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.role,
    required this.image,
    required this.isRemoved,
    required this.status,
    required this.userId,
    required this.createdBy,
    required this.associatedSociety,
    required this.emergencyContacts,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.additionalDetails,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Decode additionalDetails which is a JSON string
    final additionalDetailsMap = json['additionalDetails'] is String
        ? jsonDecode(json['additionalDetails'])
        : json['additionalDetails'];

    // Decode emergencyContacts which is a list with a single string like ["[]"]
    List<String> emergencyContactsList = [];
    if (json['emergencyContacts'] is List &&
        json['emergencyContacts'].isNotEmpty) {
      final decoded = jsonDecode(json['emergencyContacts'][0]); // decode "[]"
      emergencyContactsList = List<String>.from(decoded);
    }

    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
      role: json['role'],
      image: json['image'],
      isRemoved: json['isRemoved'],
      status: json['status'],
      userId: json['userId'],
      createdBy: json['createdBy'],
      associatedSociety: json['associatedSociety'],
      emergencyContacts: emergencyContactsList,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      additionalDetails: AdditionalDetails.fromJson(additionalDetailsMap),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'role': role,
      'image': image,
      'isRemoved': isRemoved,
      'status': status,
      'userId': userId,
      'createdBy': createdBy,
      'associatedSociety': associatedSociety,
      'emergencyContacts': emergencyContacts,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'additionalDetails': additionalDetails.toJson(),
    };
  }
  UserModel copyWith({
    String? name,
    String? email,
    String? mobile,
    String? password,
    String? role,
    String? image,
    bool? isRemoved,
    String? status,
    String? userId,
    String? createdBy,
    String? associatedSociety,
    List<String>? emergencyContacts,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    AdditionalDetails? additionalDetails,
    String? id,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      role: role ?? this.role,
      image: image ?? this.image,
      isRemoved: isRemoved ?? this.isRemoved,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      createdBy: createdBy ?? this.createdBy,
      associatedSociety: associatedSociety ?? this.associatedSociety,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      additionalDetails: additionalDetails ?? this.additionalDetails,
    );
  }
}

class AdditionalDetails {
  final String vehicleName;
  final String color;
  final String licensePlate;
  final String registrationNumber;

  AdditionalDetails({
    required this.vehicleName,
    required this.color,
    required this.licensePlate,
    required this.registrationNumber,
  });

  factory AdditionalDetails.fromJson(Map<String, dynamic> json) {
    return AdditionalDetails(
      vehicleName: json['vehicleName'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      registrationNumber: json['registrationNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleName': vehicleName,
      'color': color,
      'licensePlate': licensePlate,
      'registrationNumber': registrationNumber,
    };
  }
}