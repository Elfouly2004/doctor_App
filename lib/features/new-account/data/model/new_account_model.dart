

import 'dart:convert';

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











class DoctorLoginModel {
  final String userName;
  final String email;
  final String password;
  final String role;
  final String locations;  // تعديل من 'location' إلى 'locations'
  final Address addresses;
  final int consultationFees;
  final String specialization;

  DoctorLoginModel({
    required this.userName,
    required this.email,
    required this.password,
    this.role = "doctor",
    required this.locations,  // تعديل هنا
    required this.addresses,
    required this.consultationFees,
    required this.specialization,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'role': role,
      'locations': locations,  // تعديل من 'location' إلى 'locations'
      'addresses': addresses.toMap(),
      'consultationFees': consultationFees,
      'specialization': specialization,
    };
  }

  factory DoctorLoginModel.fromMap(Map<String, dynamic> map) {
    return DoctorLoginModel(
      userName: map['userName'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
      locations: map['locations'],  // تعديل هنا
      addresses: Address.fromMap(map['addresses']),
      consultationFees: map['consultationFees'],
      specialization: map['specialization'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorLoginModel.fromJson(String source) =>
      DoctorLoginModel.fromMap(json.decode(source));
}


class Address {
  final String street;
  final String city;
  final String zip;

  Address({
    required this.street,
    required this.city,
    required this.zip,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'city': city,
      'zip': zip,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      city: map['city'],
      zip: map['zip'],
    );
  }
}

