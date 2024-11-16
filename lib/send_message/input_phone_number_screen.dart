import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:precapstone/const/colors.dart';

class InputPhoneNumberPage extends StatelessWidget {
  final VoidCallback navigateToWriteMessage;

  const InputPhoneNumberPage({
    super.key,
    required this.navigateToWriteMessage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screenSize = MediaQuery.of(context).size;
        var isWeb = screenSize.width > 600;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: isWeb ? 500 : screenSize.width * 0.9,
                    height: isWeb
                        ? screenSize.height * 0.5
                        : screenSize.height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '발신자 연락처',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          //controller: controller,
                          maxLength: 11, // 최대 입력 길이 설정
                          keyboardType: TextInputType.phone, // 전화번호 전용 키보드
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능
                            LengthLimitingTextInputFormatter(11), // 최대 길이 제한
                          ],
                          decoration: InputDecoration(
                            hintText: '전화번호를 입력해주세요 (숫자만 입력)', // 힌트 텍스트 수정
                            filled: true,
                            fillColor: backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '수신자 연락처',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: navigateToWriteMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: deepBlueColor,
                          backgroundColor: normalBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          '이전으로',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: deepBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          '문자 전송 하기',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
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
      },
    );
  }
}
