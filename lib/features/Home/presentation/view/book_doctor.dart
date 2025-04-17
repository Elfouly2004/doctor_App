import 'package:doctor/core/utils/app_texts.dart';
import 'package:doctor/features/Home/presentation/view/widgets/choose_sick.dart';
import 'package:doctor/features/Home/presentation/view/widgets/custom_Button.dart';
import 'package:doctor/features/Home/presentation/view/widgets/texts_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/background_image/custom_background.dart';
import 'package:doctor/core/Routes/app_routes.dart';
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

              SizedBox(height: 10.h),

              Booktxtfield(hint: AppTexts.doctorname),

              locationfield(hint: AppTexts.location),

              locationfield(hint: AppTexts.Governorate),

              SizedBox(height: 15.h),

              ChooseSick(
                specialties: specialties,
                onSelected: (value) {
                  print("تم اختيار التخصص: $value");

                },
              ),

              SizedBox(height: 20.h),

              CustomButtonBook()
            ],
          ),
        ),
      ),
    );
  }
}
