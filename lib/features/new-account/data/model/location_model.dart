import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationModel {
  final String id;
  final String name;

  LocationModel({required this.id, required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}



Future<List<LocationModel>> fetchLocations() async {
  final response = await http.get(Uri.parse('http://192.168.1.8:3000/location/'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List list = data['data'];
    return list.map((item) => LocationModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load locations');
  }
}
