import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'doctor_login_state.dart';

class DoctorLoginCubit extends Cubit<DoctorLoginState> {
  DoctorLoginCubit() : super(DoctorLoginInitial());
}
