import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:doctor/features/new-account/presentation/view/widgets/txtfield_time.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../Home/presentation/view/book_doctor.dart';
import '../../../../Login/presentation/view/widgets/custom_Button.dart';
import '../../../../Login/presentation/view/widgets/custom_row_field.dart';
import '../../../data/model/location_model.dart';
import '../../../data/model/new_account_model.dart';
import '../../../data/model/spclazition_model.dart';
import '../../../data/repo/Greate_account_impelemntation.dart';
import '../../controller/doctoraccount_cubit.dart';
import '../../controller/greateaccount_cubit.dart';

class DocWidget extends StatefulWidget {
  const DocWidget({super.key});

  @override
  State<DocWidget> createState() => _DocWidgetState();
}

class _DocWidgetState extends State<DocWidget> {
  List<LocationModel> locations = [];
  LocationModel? selectedLocation;
  List<SpecializationModel> specialization = [];
  SpecializationModel? selectedSpecialization;
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  @override
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
    final cubit = BlocProvider.of<DoctoraccountCubit>(context);

    return BlocConsumer<DoctoraccountCubit, DoctoraccountState>(
      listener: (context, state) {
        if (state is GreateAccountDocFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is GreateAccountDocSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account created successfully')));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookDoctor()),
          );
        }
      },
      builder: (context, state) {
        if (state is GreateAccountDocLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRowField(txt: AppTexts.name,controller: cubit.userName,),
              SizedBox(height: 16.h),
              CustomRowField(txt: AppTexts.email,controller: cubit.Email,),
              SizedBox(height: 16.h),
              CustomRowField(txt: AppTexts.pass,controller: cubit.password,),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRowField_time(txt: AppTexts.cv),
                  CustomRowField_time(txt: AppTexts.price,controller: cubit.pricecon,),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "الموقع",
                    style: GoogleFonts.almarai(
                      color: AppColors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "التخصص",
                    style: GoogleFonts.almarai(
                      color: AppColors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<LocationModel>(
                            isExpanded: true,
                            hint: const Text(
                              'Choose Location',
                              style: TextStyle(fontSize: 16),
                            ),
                            items: locations.map((loc) {
                              return DropdownMenuItem<LocationModel>(
                                value: loc,
                                child: Text(
                                  loc.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            value: selectedLocation,
                            onChanged: (value) {
                              setState(() {
                                selectedLocation = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),


                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<SpecializationModel>(
                            isExpanded: true,
                            hint: const Text(
                              'Choose Specialization',
                              style: TextStyle(fontSize: 16),
                            ),
                            items: specialization.map((spec) {
                              return DropdownMenuItem<SpecializationModel>(
                                value: spec,
                                child: Text(
                                  spec.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            value: selectedSpecialization,
                            onChanged: (value) {
                              setState(() {
                                selectedSpecialization = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: streetController,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "أدخل الشارع",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: cityController,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "أدخل المدينة",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5),
              TextField(
                controller: zipController,
                style: TextStyle(color: Colors.black, fontSize: 14), // تصغير حجم الخط داخل الـ TextField
                decoration: InputDecoration(
                  hintText: "أدخل الرمز البريدي",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
              ),




              SizedBox(height: 25),

              Center(
                child: CustomButton(
                  txt: AppTexts.register,
                  onPressed: () {
                    // Create the Address object
                    Address address = Address(
                      street: "asssssss",
                      city: "Tanta",
                      zip: "21212",
                    );

                    context.read<DoctoraccountCubit>().GreateacoountDoctor(
                      context,
                      specialization: selectedLocation?.id,
                      location: selectedSpecialization?.id,
                      addresss: address,
                    );
                  },



                ),
              )

            ],
          ),
        );
      },
    );
  }
}
