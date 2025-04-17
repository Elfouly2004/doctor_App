class UserModelToRegister {
  final String username;
  final String email;
  final String password;
  final String cpassword;

  UserModelToRegister({
    required this.username,
    required this.email,
    required this.password,
    required this.cpassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "userName": username,
      "email": email,
      "password": password,
      "Cpassword": cpassword,
    };
  }
}