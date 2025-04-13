import 'package:doctor/features/new-account/presentation/view/widgets/txtfield_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../Login/presentation/view/widgets/custom_Button.dart';
import '../../../../Login/presentation/view/widgets/custom_row_field.dart';
import '../../../../profile/profile.dart';
class  DoctorWidget extends StatefulWidget {
  const  DoctorWidget({super.key});

  @override
  State<DoctorWidget> createState() => _DoctorWidgetState();
}

class _DoctorWidgetState extends State<DoctorWidget> {
  @override
  Widget build(BuildContext context) {

    String? selectedTimeFrom;
    String? selectedTimeTo;
    final TextEditingController priceController = TextEditingController();
    final TextEditingController cvController = TextEditingController();

    List<String> times = ['08:00', '09:00', '10:00', '11:00', '12:00'];

    return Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        children: [


          CustomRowField(txt: AppTexts.name,) ,


          SizedBox(height: MediaQuery.sizeOf(context).height*0.025,),

          CustomRowField(txt: AppTexts.email,),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.025,),

          CustomRowField(txt: AppTexts.pass,),

          SizedBox(height: MediaQuery.sizeOf(context).height*0.025,),

          CustomRowField(txt: AppTexts.repass,),


          SizedBox(height: MediaQuery.sizeOf(context).height*0.025,),



          Row(
            textDirection: TextDirection.rtl,
            children: [

              SizedBox(width: 5.w),


              Text("المعاد من",

                style: GoogleFonts.almarai(
                  color: AppColors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),


              ),



              SizedBox(width: 5.w),



              SizedBox(
                height: 45.h,
                width: 110.w,
                child: DropdownButtonFormField<String>(
                  value: selectedTimeFrom,style: TextStyle(fontSize: 9,color: Colors.black,fontWeight: FontWeight.bold),
                  items: times.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTimeFrom = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),


              SizedBox(width: 10.w),

              Text("إلى",

                style: GoogleFonts.almarai(
                  color: AppColors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),


              ),

              SizedBox(width: 10.w),


              SizedBox(
                height: 45.h,
                width:110.w ,
                child: DropdownButtonFormField<String>(
                  value: selectedTimeTo,style: TextStyle(fontSize: 9,color: Colors.black),
                  items: times.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTimeTo = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none,),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),

              SizedBox(width: 5.w),

            ],
          ),


          SizedBox(height: 5.h),


            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
           children: [


             CustomRowField_time(txt: AppTexts.cv,),

             CustomRowField_time(txt: AppTexts.price,),



            ],
           ),




          SizedBox(height: 20),



          CustomButton(
            txt: AppTexts.register,
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));

            },
          ),






        ],
      ),
    );
  }
}
