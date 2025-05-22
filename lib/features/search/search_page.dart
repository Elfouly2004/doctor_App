import 'package:flutter/material.dart';
import '../../core/background_image/custom_background.dart';
import '../Home/data/model/search_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<DoctorResponse> getDoctors({
  required String specialization,
  required String location,
}) async {
  final Uri url = Uri.parse(
    'http://192.168.1.3:3000/doctor/filter?specialization=$specialization&location=$location',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return DoctorResponse.fromJson(data);
  } else {
    throw Exception('Failed to load doctors: ${response.statusCode}');
  }
}


void fetchDoctors() async {
  try {
    final result = await getDoctors(
      specialization: '67eecee4b0dfd64e8d723edb',
      location: '67ebf8088a804746055d9be6',
    );

    print("Total Doctors: ${result.totalCount}");
    for (var doctor in result.doctors) {
      print("Doctor ID: ${doctor.id}");
      print("Specialization: ${doctor.specialization.name}");
    }
  } catch (e) {
    print("Error: $e");
  }
}

class DoctorsPage extends StatefulWidget {
  final String specializationId;
  final String locationId;

  const DoctorsPage({
    Key? key,
    required this.specializationId,
    required this.locationId,
  }) : super(key: key);

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  late Future<DoctorResponse> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = getDoctors(
      specialization: widget.specializationId,
      location: widget.locationId,
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: const Color(0xFF0D47A1),
      body: Column(
        children: [
          const SizedBox(height: 80),
          const Text(
            'Our Doctors',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<DoctorResponse>(
              future: futureDoctors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.doctors.isEmpty) {
                  return const Center(child: Text('No doctors found.'));
                }

                final doctors = snapshot.data!.doctors;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blueAccent,
                            child: const Icon(Icons.person, color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.specialization.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Fees: \$${doctor.consultationFees}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}


