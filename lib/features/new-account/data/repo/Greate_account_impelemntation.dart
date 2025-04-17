import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/failure.dart';
import '../model/new_account_model.dart';
import 'Greate_account_repo.dart';

class GreateAccountImplementation implements GreateAccountRepo {
  @override
  Future<Either<Failure, UserModelToRegister>> Greate_account({
    required UserModelToRegister userModelToRegister,
  }) async {
    try {
      final uri = Uri.parse("http://192.168.1.8:3000/auth/register");

      final response = await http.post(
        uri,
        body: jsonEncode(userModelToRegister.toJson()),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        final Map<String, dynamic> body = jsonDecode(response.body);

        final String? token = body["token"];
        final String? msg = body["msg"];

        if (msg == "done" && token != null) {
          print("Token: $token");
          return right(userModelToRegister);
        } else {
          return left(ApiFailure(message: body["msg"] ?? "Registration failed"));
        }
      }
          else {
        return left(ApiFailure(message: "Server error: ${response.statusCode}"));
      }
    } on SocketException {
      return left(NoInternetFailure(message: "No Internet connection"));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
