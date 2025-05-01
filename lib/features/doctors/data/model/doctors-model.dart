class Doctor_model {
  final String id;
  final UserrModel? user;
  final bool isVerified;

  Doctor_model({
    required this.id,
    this.user,
    required this.isVerified,
  });

  factory Doctor_model.fromJson(Map<String, dynamic> json) {
    return Doctor_model(
      id: json['_id'],
      user: json['user'] != null ? UserrModel.fromJson(json['user']) : null,
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

class UserrModel {
  final String? userName;

  UserrModel({this.userName});

  factory UserrModel.fromJson(Map<String, dynamic> json) {
    return UserrModel(
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
    };
  }
}
