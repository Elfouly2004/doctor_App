class Doctor_model {
  final String id;
  final UserModel? user;
  final bool isVerified;

  Doctor_model({
    required this.id,
    this.user,
    required this.isVerified,
  });

  factory Doctor_model.fromJson(Map<String, dynamic> json) {
    return Doctor_model(
      id: json['_id'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user?.toJson(),
      'isVerified': isVerified,
    };
  }
}




class UserModel {
  final String? userName;

  UserModel({this.userName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
    };
  }
}
