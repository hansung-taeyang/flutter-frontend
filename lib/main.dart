import 'package:flutter/material.dart';
import 'package:precapstone/home/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/sign_in_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null; // 토큰이 존재하면 true 반환
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()), // 로딩 인디케이터
            ),
          );
        } else {
          FlutterNativeSplash.remove(); // 스플래시 화면 제거
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: snapshot.data == true ? const MainPage() : LoginPage(),
          );
        }
      },
    );
  }
}
