import 'package:doctor/core/utils/app_colors.dart';
import 'package:doctor/features/profile/profle_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/background_image/custom_background.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfleScreen(),));

          },
          icon: Icon(CupertinoIcons.profile_circled,color: Colors.blue.withOpacity(0.8),)
        ),
        backgroundColor: Colors.white,
      ),
      body: CustomBackground(

      ),
    );
  }
}

