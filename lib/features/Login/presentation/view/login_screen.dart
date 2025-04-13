import 'package:doctor/core/utils/app_colors.dart';
import 'package:doctor/core/utils/app_texts.dart';
import 'package:doctor/features/Login/presentation/view/widgets/custom_Button.dart';
import 'package:doctor/features/Login/presentation/view/widgets/custom_row_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/background_image/custom_background.dart';
import '../../../new-account/presentation/view/Registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDoctor = true;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
        child:Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [

              SizedBox(height: MediaQuery.sizeOf(context).height*0.2,),

              Text(
                AppTexts.Login,
                style: GoogleFonts.almarai(
                  color: AppColors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700
                ),
              ),


              SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

              CustomRowField(txt: AppTexts.email,)  ,


              SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),

              CustomRowField(txt: AppTexts.pass,),

              SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),


              CustomButton(
                txt: AppTexts.login_button,
                onPressed: () {

              },

              ),


              SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),


              CustomButton(
          txt:AppTexts.newaccount_button,
                onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen(),));
              },),

              SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),


              InkWell(
                onTap: () {

                },
                child:Text(AppTexts.forgetpass ,

                  style: GoogleFonts.almarai(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                               decoration: TextDecoration.underline,
                          decorationColor: AppColors.white

                            ),




                ) ,
              )
            ],
          ),
        )
      )
    );
  }
}
