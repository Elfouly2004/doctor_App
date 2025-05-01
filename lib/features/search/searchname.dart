import 'package:flutter/material.dart';
import '../../core/background_image/custom_background.dart';
import 'custom-txt-field.dart';
import 'model/doc_model.dart';
class DoctorsPage2 extends StatefulWidget {
  const DoctorsPage2({Key? key}) : super(key: key);

  @override
  State<DoctorsPage2> createState() => _DoctorsPage2State();
}
class _DoctorsPage2State extends State<DoctorsPage2> {
  late Future<DoctorResponse2> futureDoctors;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureDoctors = getDoctorsByName(name: '');
  }


  void searchDoctorsByName() {
    setState(() {
      futureDoctors = getDoctorsByName(name: searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: CustomBackground(
        child: Column(
          children: [
            SizedBox(height: 150),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
              child: CustomTextformfeild(
                controller:searchController ,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: searchDoctorsByName,
                ),  hintText: 'Enter doctor namem',
                keyboardType: TextInputType.name,
              ),
            ),


            FutureBuilder<DoctorResponse2>(
              future: futureDoctors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                  return const Center(child: Text('No doctors found.'));
                }

                final doctors = snapshot.data!.data;

                return Expanded(
                  child: ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];

                      return Card(
                        color: Colors.white.withOpacity(0.8),
                        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(doctor.userName),
                          subtitle: Text('Doctor ID: ${doctor.id}'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
