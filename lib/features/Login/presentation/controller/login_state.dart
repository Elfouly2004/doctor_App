part of 'login_cubit.dart';

@immutable
sealed class LoginStates {}
final class LoginInitial extends LoginStates {}
class LoginLoadingState extends LoginStates{ }
class LoginSuccessState extends LoginStates{
  final UserModel userModel;LoginSuccessState({required this.userModel});
}
class LoginFailureState extends LoginStates{
  final String errorMessage;LoginFailureState({required this.errorMessage});}
class LoginGoogleFailureState extends LoginStates
{final String errorMessage;LoginGoogleFailureState({required this.errorMessage});}