import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:precapstone/home/main_screen.dart';
import 'package:precapstone/authentication/sign_up_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600; // 화면 너비 600px 이상일 경우 웹으로 간주

    OutlineInputBorder _buildRoundedInputBorder() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none, // 투명한 테두리로 설정
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: BACKFROUND_COLOR,
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
                    decoration: InputDecoration(
                      hintText: '이메일',
                      filled: true,
                      fillColor: WHITE_COLOR,
                      hoverColor: INPUT_HOVER_COLOR,
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
                    decoration: InputDecoration(
                      hintText: '비밀번호',
                      filled: true,
                      fillColor: WHITE_COLOR,
                      hoverColor: INPUT_HOVER_COLOR,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: isWeb ? 500 : double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: DEEP_BLUE_COLOR,
                      backgroundColor: NORMAL_BLUE_COLOR,
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
                      foregroundColor: DEEP_BLUE_COLOR,
                      backgroundColor: LIGHT_BLUE_COLOR,
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
