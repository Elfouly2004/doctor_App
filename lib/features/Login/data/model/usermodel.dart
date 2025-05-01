class UserModel {
  final String email;
  final String password;
  final bool isVerified;

  UserModel({
    required this.email,
    required this.password,
    this.isVerified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "isVerified": isVerified,
    };
  }
}