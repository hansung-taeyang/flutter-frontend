import 'package:flutter/material.dart';
import 'package:precapstone/authentication/sign_in_logic.dart';
import 'package:precapstone/authentication/sign_in_screen.dart';
import 'package:precapstone/const/colors.dart';

class UserDashboardPage extends StatelessWidget {
  const UserDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return LayoutBuilder(
      builder: (context, constraints) {
        var screenSize = MediaQuery.of(context).size;
        var isWeb = screenSize.width > 600;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            // 스크롤 가능한 구조로 변경 (웹 화면에서 bottom overflow 문제 방지)
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: isWeb ? 500 : screenSize.width * 0.9,
                    height: 160,
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightPinkColor,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: normalPinkColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Expanded(
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
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // 정보 수정 버튼의 기능 추가 예정
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightBlueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text("정보수정",
                                  style: TextStyle(color: deepBlueColor)),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () async {
                                await authService.logout(); // 토큰 삭제
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
                              child: const Text(
                                "로그아웃",
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // 박스 아래 여백
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: isWeb ? 500 : screenSize.width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              // 공지사항 버튼 기능 추가 예정
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: normalPinkColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              "공지사항",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: isWeb ? 500 : screenSize.width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              // 서비스 안내 버튼 기능 추가 예정
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: deepPinkColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
