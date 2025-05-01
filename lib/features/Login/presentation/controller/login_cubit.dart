import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../data/model/usermodel.dart';
import '../../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();

  final LoginRepo loginRepo;

  Future<void> login() async {
    emit(LoginLoadingState());
    var result = await loginRepo.login(
      email: Email.text.trim(),
      pass: password.text.trim(),
    );

    result.fold(
          (left) {
        emit(LoginFailureState(errorMessage: left.message));
      },
          (right) async {
        emit(LoginSuccessState(userModel: right));
      },
    );
  }

  Future<void> approveDoctor(String doctorId) async {
    // هنا يتم تنفيذ العملية الخاصة بالموافقة على الحساب
    try {
      // إذا كانت العملية ناجحة، يمكنك هنا استدعاء دالة للموافقة على الطبيب
      // مثل استدعاء API أو التحقق من حالة الطبيب في قاعدة البيانات
      emit(LoginSuccessState(userModel: UserModel(email: "tamineproject1@gmail.com", password: "12345678T#")));
    } catch (e) {
      emit(LoginFailureState(errorMessage: "Failed to approve the doctor"));
    }
  }
}
