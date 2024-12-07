import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:precapstone/const/server_address.dart';

// 유저 정보 저장 함수
Future<void> saveUserCredentials(String email, String password) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', email);
  await prefs.setString('userPassword', password);
}

// 유저 정보 불러오기 함수
Future<Map<String, String>> getUserCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('userEmail') ?? '';
  final password = prefs.getString('userPassword') ?? '';
  return {'email': email, 'password': password};
}

Future<String> signUp(String id, String password, String phone) async {
  final url = Uri.parse('http://$address/v1/signUp');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': id,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      return ''; // 회원가입 성공
    } else if (response.statusCode == 409) {
      return '     이미 가입되어있는 회원 입니다.';
    } else if (response.statusCode == 400) {
      return '     비밀번호의 형식을 다시 확인해 주세요.';
    } else {
      return '     에러 발생: ${response.statusCode}';
    }
  } catch (e) {
    return '     에러 발생: $e';
  }
}

// 로그인 함수
Future<bool> signIn(String email, String password) async {
  final url = Uri.parse('http://$address/v1/signIn');

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
      return false; // 로그인 실패
    }
  } catch (e) {
    return false;
  }
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

Future<String> duplicateCheck(String id) async {
  final url = Uri.parse('http://$address/v1/signUp/idDuplicateCheck');
  // 중복 확인 로직
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': id,
      }),
    );

    if (response.statusCode == 200) {
      return '     사용 가능한 아이디입니다.';
    } else if (response.statusCode == 409) {
      return '     이미 사용 중인 아이디입니다.';
    } else if (response.statusCode == 400) {
      return '     이메일 형식을 다시 확인해 주세요.';
    } else {
      return '     에러 발생: ${response.statusCode}';
    }
  } catch (e) {
    return '     에러 발생: $e';
  }
}
