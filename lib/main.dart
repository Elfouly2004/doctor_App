import 'package:doctor/core/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/Routes/router_generator.dart';
import 'features/Login/data/repo/login_repo_implementation.dart';
import 'features/Login/presentation/controller/login_cubit.dart';
import 'features/Splash_screen/splash_screen.dart';
import 'features/new-account/data/repo/Greate_account_impelemntation.dart';
import 'features/new-account/presentation/controller/doctoraccount_cubit.dart';
import 'features/new-account/presentation/controller/greateaccount_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1006),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return  MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => GreateAccountCubit(GreateAccountImplementation(),)
            ),
            BlocProvider(create: (context) => LoginCubit(LoginRepoImplementation(),)) ,

        BlocProvider(      create: (context) => DoctoraccountCubit(
          GreateAccountImplementation(),
        ),
            ),

          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'طمني',
            initialRoute: AppRoutes.splash,
            onGenerateRoute: RouterGenerator().generateRoute,
          
            // home: const LoginScreen(),
          ),
        );
      },

    );
  }
}
