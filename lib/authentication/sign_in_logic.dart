import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:precapstone/const/server_address.dart';

class AuthService {
  // 로그인 함수
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('http://$address:3000/v1/signIn');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // 토큰을 SharedPreferences에 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return true; // 로그인 성공
      } else {
        print('로그인 실패: ${response.statusCode}');
        return false; // 로그인 실패
      }
    } catch (e) {
      print('에러 발생: $e');
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
