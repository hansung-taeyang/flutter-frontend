import 'package:flutter/material.dart';
import 'package:precapstone/authentication/sign_in_logic.dart';
import 'package:precapstone/const/colors.dart';
import 'package:precapstone/home/main_screen.dart';
import 'package:precapstone/authentication/sign_up_screen.dart';

import '../const/user_account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = ' ';

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final isLoggedIn = await _authService.login(email, password);

    if (isLoggedIn) {
      setState(() {
        _errorMessage = ' ';
      });
      userEmail = email;
      userPassword = password;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = '     이메일 또는 비밀번호가 잘못되었습니다.';
      });

      // 에러 메시지 사라지게 하기
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _errorMessage = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600; // 화면 너비 600px 이상일 경우 웹으로 간주

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/logo.png'),
                  width: 200,
                  height: 100,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: isWeb ? 500 : double.infinity,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: '이메일',
                      filled: true,
                      fillColor: whiteColor,
                      hoverColor: inputHoverColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isWeb ? 500 : double.infinity,
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: '비밀번호',
                      filled: true,
                      fillColor: whiteColor,
                      hoverColor: inputHoverColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // 에러 메시지 표시
                SizedBox(
                  width: isWeb ? 500 : double.infinity,
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: normalRedColor, fontSize: 14),
                  ),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: isWeb ? 500 : double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: deepBlueColor,
                      backgroundColor: normalBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: isWeb ? 500 : double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: deepBlueColor,
                      backgroundColor: lightBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
