import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<String, Map<String, dynamic>>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode != 201) {
        return left(response.body);
      }
      final user = jsonDecode(response.body) as Map<String, dynamic>;
      return right(user);
      
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
