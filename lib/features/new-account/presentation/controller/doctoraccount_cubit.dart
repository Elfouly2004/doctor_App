import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/model/new_account_model.dart';
import '../../data/repo/Greate_account_repo.dart';
part 'doctoraccount_state.dart';

class DoctoraccountCubit extends Cubit<DoctoraccountState> {
  DoctoraccountCubit(this.greateAccountRepo) : super(DoctoraccountInitial());


  final TextEditingController Email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final TextEditingController pricecon = TextEditingController();

  final GreateAccountRepo greateAccountRepo;Future<void> GreateacoountDoctor(BuildContext context,
      {required addresss, required location, required specialization}) async {
    emit(GreateAccountDocLoadingState());
    try {
      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(Email.text.trim());

      if (!emailValid) {
        emit(GreateAccountDocFailureState(errorMessage: "Please enter a correct email."));
      } else if (userName.text.isEmpty) {
        emit(GreateAccountDocFailureState(errorMessage: "Name cannot be empty."));
      } else if (password.text.isEmpty) {
        emit(GreateAccountDocFailureState(errorMessage: "Password cannot be empty."));
      } else {
        int price = int.parse(pricecon.text.trim());

        var result = await greateAccountRepo.Greate_account_Doctor(
          doctorLoginModel: DoctorLoginModel(
              userName: userName.text,
              email: Email.text.trim(),
              password: password.text.trim(),
              consultationFees: price,
              addresses: addresss,
              location: location,
              specialization: specialization,
              role: "doctor"
          ),
        );

        result.fold(
              (left) {
            emit(GreateAccountDocFailureState(errorMessage: left.message));
            print("Error: ${left.message}");  
          },
              (right) async {
            emit(GreateAccountDocSuccessState(doctorLoginModel: right));
          },
        );
      }
    } catch (e) {
      print("Unexpected error: $e");
      emit(GreateAccountDocFailureState(errorMessage: "An unexpected error occurred."));
    }
  }


}
