import 'package:flutter/material.dart';
import 'package:precapstone/authentication/authentication_logic.dart';
import 'package:precapstone/const/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _errorMessage = ' ';

  void _signUp() async {
    // 회원가입 진행

    final id = _idController.text;
    final password = _passwordController.text;
    final passwordCheck = _passwordCheckController.text;
    final phone = _phoneController.text;

    // 비밀번호가 6-15자 영문/숫자/특수문자 조합이 아닐 때
    if (!RegExp(
            r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,15}$')
        .hasMatch(password)) {
      setState(() {
        _errorMessage = '     비밀번호의 형식을 다시 확인해 주세요.';
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _errorMessage = '';
        });
      });
      return;
    }
    // 비밀번호와 비밀번호 확인이 다를 때
    if (password != passwordCheck) {
      setState(() {
        _errorMessage = '     비밀번호 확인이 비밀번호와 일치하지 않습니다.';
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _errorMessage = '';
        });
      });
      return;
    }
    // 휴대폰 번호가 11자리가 아닐 때
    if (phone.length != 11) {
      setState(() {
        _errorMessage = '     휴대폰 번호를 다시 확인해 주세요.';
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _errorMessage = '';
        });
      });
      return;
    }

    final isSignedUp = await signUp(id, password, phone);

    if (isSignedUp == '') {
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = isSignedUp;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _errorMessage = '';
        });
      });
    }
  }

  void _duplicateCheck() async {
    // 이메일 아이디 중복 확인

    final id = _idController.text;

    // 아무것도 입력하지 않았을 때
    if (id.isEmpty) {
      setState(() {
        _errorMessage = '     아이디를 입력해주세요.';
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _errorMessage = '';
        });
      });
      return;
    }
    final isNotDuplicated = await duplicateCheck(id);

    setState(() {
      _errorMessage = isNotDuplicated;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _errorMessage = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600; // 화면 너비 600px 이상일 경우 웹으로 간주

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: '아이디(이메일)',
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
                    const SizedBox(width: 10), // 버튼과 TextField 사이에 간격 추가
                    ElevatedButton(
                      onPressed: _duplicateCheck,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: deepBlueColor,
                        backgroundColor: lightBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: const Text(
                        '중복 확인',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: isWeb ? 500 : double.infinity,
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: '비밀번호(6-15자 영문/숫자/특수문자 조합)',
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
              const SizedBox(height: 20),
              SizedBox(
                width: isWeb ? 500 : double.infinity,
                child: TextField(
                  obscureText: true,
                  controller: _passwordCheckController,
                  decoration: InputDecoration(
                    hintText: '비밀번호 확인',
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
              const SizedBox(height: 20),
              SizedBox(
                width: isWeb ? 500 : double.infinity,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: '휴대폰 번호(숫자만 입력)',
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
              const SizedBox(height: 15),
              SizedBox(
                width: isWeb ? 500 : double.infinity,
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: normalRedColor, fontSize: 14),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: deepBlueColor,
                    backgroundColor: normalBlueColor,
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
    );
  }
}
