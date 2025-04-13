import 'package:flutter/material.dart';

import '../../../../../core/utils/app_texts.dart';
import '../../../../Login/presentation/view/widgets/custom_Button.dart';
import '../../../../Login/presentation/view/widgets/custom_row_field.dart';

class SickWidget extends StatelessWidget {
  const SickWidget({super.key});

  @override
  Widget build(BuildContext context) {
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



          SizedBox(height: 60),



          CustomButton(
            txt: AppTexts.register,
            onPressed: () {},
          ),





        ],
      ),
    );
  }
}
