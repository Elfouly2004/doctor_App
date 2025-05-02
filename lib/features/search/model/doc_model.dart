import 'dart:convert';
import 'package:http/http.dart' as http;

class Doctor {
  final String id;
  final String userName;

  Doctor({required this.id, required this.userName});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      userName: json['userName'],
    );
  }
}

class DoctorResponse2 {
  final bool success;
  final List<Doctor> data;

  DoctorResponse2({required this.success, required this.data});

  factory DoctorResponse2.fromJson(Map<String, dynamic> json) {
    return DoctorResponse2(
      success: json['success'],
      data: (json['data'] as List)
          .map((doctorJson) => Doctor.fromJson(doctorJson))
          .toList(),
    );
  }
}


Future<DoctorResponse2> getDoctorsByName({required String name}) async {
  final Uri url = Uri.parse('http://192.168.1.39:3000/doctor/search?name=$name');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return DoctorResponse2.fromJson(data);
  } else {
    throw Exception('Failed to load doctors: ${response.statusCode}');
  }
}

void fetchDoctorsName() async {
  try {
    final response = await getDoctorsByName(name: 'mostafa');
    if (response.success) {
      for (var doctor in response.data) {
        print('Doctor: ${doctor.userName}, ID: ${doctor.id}');
      }
    } else {
      print('No doctor ');
    }
  } catch (e) {
    print('Error: $e');
  }
}



