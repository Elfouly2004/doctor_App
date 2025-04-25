import 'package:doctor/core/utils/app_texts.dart';
import 'package:doctor/features/Home/presentation/view/widgets/choose_sick.dart';
import 'package:doctor/features/Home/presentation/view/widgets/custom_Button.dart';
import 'package:doctor/features/Home/presentation/view/widgets/texts_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/background_image/custom_background.dart';
import 'package:doctor/core/Routes/app_routes.dart';

import '../../../new-account/data/model/location_model.dart';
import '../../../new-account/data/model/spclazition_model.dart';
import '../../../search/search_page.dart';
class BookDoctor extends StatefulWidget {
  const BookDoctor({super.key});

  @override
  State<BookDoctor> createState() => _BookDoctorState();
}

class _BookDoctorState extends State<BookDoctor> {
  String? selectedSpecialty;
  bool isExpanded = false;

  List<String> specialties = [
    "امراض جهاز هضمي",
    "امراض غدد صماء",
    "امراض روماتيزم",
  ];
  List<LocationModel> locations = [];
  LocationModel? selectedLocation;
  List<SpecializationModel> specialization = [];
  SpecializationModel? selectedSpecialization;
  void initState() {
    super.initState();
    loadLocations();
    loadspec();
  }

  Future<void> loadLocations() async {
    try {
      final result = await fetchLocations();
      setState(() {
        locations = result;
      });
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> loadspec() async {
    try {
      final result = await fetchSpecializations();
      setState(() {
        specialization = result;
      });
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ProfleScreen);
            },
            icon: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.blue.withOpacity(0.8),
            )),
        backgroundColor: Colors.white,
      ),
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),

              Text(
                "احجز دكتور",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),

              // SizedBox(height: 10.h),
              //
              //
              //
              // locationfield(hint: AppTexts.location),
              //
              // locationfield(hint: AppTexts.Governorate),

              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(Icons.location_on, color: Colors.redAccent),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<LocationModel>(
                              isExpanded: true,
                              hint: Text(
                                'اختر الموقع',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                textAlign: TextAlign.right,
                              ),
                              items: locations.map((loc) {
                                return DropdownMenuItem<LocationModel>(
                                  value: loc,
                                  child: Text(
                                    loc.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              }).toList(),
                              value: selectedLocation,
                              onChanged: (value) {
                                setState(() {
                                  selectedLocation = value;
                                });
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(Icons.location_on, color: Colors.redAccent),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<SpecializationModel>(
                              isExpanded: true,
                              hint: Text(
                                'اختر التخصص',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                textAlign: TextAlign.right,
                              ),
                              items: specialization.map((spec) {
                                return DropdownMenuItem<SpecializationModel>(
                                  value: spec,
                                  child: Text(
                                    spec.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              }).toList(),
                              value: selectedSpecialization,
                              onChanged: (value) {
                                setState(() {
                                  selectedSpecialization = value;
                                });
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              CustomButtonBook(
                onTap: () {

                  if(  selectedSpecialization!.id != null && selectedLocation!.id != null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorsPage(
                          specializationId:"${selectedSpecialization!.id}",
                          locationId:"${selectedLocation!.id}",
                        ),
                      ),
                    );
                  }


                  print( selectedSpecialization!.id );
                  print( selectedLocation!.id );


                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
