import 'package:doctor/core/Routes/app_routes.dart';
import 'package:doctor/core/utils/app_colors.dart';
import 'package:doctor/core/utils/app_texts.dart';
import 'package:doctor/features/Login/presentation/view/widgets/custom_Button.dart';
import 'package:doctor/features/Login/presentation/view/widgets/custom_row_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/background_image/custom_background.dart';
import '../controller/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Center(
                    child: CircularProgressIndicator(color: AppColors.button),
                  ),
                );
              } else if (state is LoginSuccessState) {
                Navigator.pop(context); // remove loader
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login Successful")),
                );
                Navigator.pushNamed(context, AppRoutes.BookDoctor);

              } else if (state is LoginFailureState) {
                Navigator.pop(context); // remove loader
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<LoginCubit>();

              return Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                  Text(
                    AppTexts.Login,
                    style: GoogleFonts.almarai(
                      color: AppColors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                  CustomRowField(txt: AppTexts.email, controller: cubit.Email),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                  CustomRowField(txt: AppTexts.pass, controller: cubit.password),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                  CustomButton(
                    txt: AppTexts.login_button,
                    onPressed: () {
                      cubit.login();
                      cubit.Email.clear();
                      cubit.password.clear();
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                  CustomButton(
                    txt: AppTexts.newaccount_button,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppTexts.forgetpass,
                      style: GoogleFonts.almarai(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}