import 'package:flutter/material.dart';
import 'package:precapstone/authentication/authentication_logic.dart';
import 'package:precapstone/authentication/sign_in_screen.dart';
import 'package:precapstone/const/colors.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  Future<String> _getUserEmail() async {
    final credentials = await getUserCredentials();
    return credentials['email'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              FutureBuilder<String>(
                future: _getUserEmail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // 로딩 중 표시
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // 에러 발생 시 표시
                  } else {
                    final userEmail = snapshot.data ?? '';
                    return Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: isWeb ? 500 : screenSize.width * 0.9,
                      height: 160,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightGreyColor,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: normalGreyColor,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        userEmail.length > 11
                                            ? '${userEmail.substring(0, 8)}...${userEmail.substring(userEmail.length - 3)}'
                                            : userEmail,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
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
                                  await logout(); // 토큰 삭제
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: normalGreyColor,
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
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: isWeb ? 500 : screenSize.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: normalBlueColor,
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightBlueColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
