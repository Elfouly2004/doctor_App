import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/background_image/custom_background.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../search/avilaible_slots_screen.dart';

class SearchArea extends StatefulWidget {
  const SearchArea({super.key});

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  final TextEditingController _areaController = TextEditingController();
  List<dynamic> doctors = [];
  bool isLoading = false;

  Future<void> searchDoctors(String area) async {
    setState(() {
      isLoading = true;
      doctors = [];
    });

    try {
      final response = await http.get(
        Uri.parse('${AppTexts.baseurl}/doctor/area?area=$area'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success']) {
          setState(() {
            doctors = jsonData['data'];
          });
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [

                SizedBox(height: 110,),

                // Title
                Text(
                  'Find Doctors by Area',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),

                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _areaController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter area name...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          final area = _areaController.text.trim();
                          if (area.isNotEmpty) {
                            searchDoctors(area);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Result list or loading
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                      : doctors.isEmpty
                      ? Center(
                    child: Text(
                      'No doctors found.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                      : ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return GestureDetector(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingSlotsPage(
                                locations:doctor['locations'],
                                price: doctor['consultationFees'] ?? 0,
                                doctorId: doctor["id"],
                                doctorName: doctor["userName"],
                                doctorDescription:doctor['specialization'] ,
                              ),
                            ),
                          );

                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(
                              doctor['userName'],
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                  doctor['specialization'],
                                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                ),      Text(
                                  doctor['locations'],
                                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            trailing: Text(
                              '${doctor['consultationFees']} EGP',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
