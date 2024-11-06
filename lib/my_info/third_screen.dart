import 'package:flutter/material.dart';
import 'package:precapstone/authentication/login_screen.dart';
import 'package:precapstone/const/colors.dart'; // LoginPage가 정의된 파일 import

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0), // 위 여백을 약간만 남김
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 10.0, top: 20.0, bottom: 20.0),
                  width: 400,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: lightPinkColor,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: normalPinkColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "user@example.com",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FractionallySizedBox(
                              widthFactor: 0.67,
                              child: ElevatedButton(
                                onPressed: () {
                                  // 정보 수정 버튼의 기능 추가
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightBlueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text("정보수정",
                                    style: TextStyle(color: deepBlueColor)),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FractionallySizedBox(
                              widthFactor: 0.67,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: greyColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  "로그아웃",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // 박스 아래 여백
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      // 공지사항 버튼 기능 추가
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: normalPinkColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "공지사항",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // 버튼 간 간격
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      // 서비스 안내 버튼 기능 추가
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deepPinkColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "서비스 안내",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18.0,
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
