import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:precapstone/const/message_content.dart';

class WriteMessagePage extends StatelessWidget {
  String messageContent = '';
  final VoidCallback navigateToCheckImage;

  final VoidCallback navigateToInputPhoneNumber;

  final TextEditingController messageContentController =
      TextEditingController();

  WriteMessagePage({
    super.key,
    required this.messageContent,
    required this.navigateToCheckImage,
    required this.navigateToInputPhoneNumber,
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
                    child: TextField(
                      controller: messageContentController
                        ..text = currentMessageContent.isNotEmpty
                            ? currentMessageContent
                            : '', // 초기 값 설정
                      maxLines: 19,
                      maxLength: 900,
                      onChanged: (value) {
                        currentMessageContent =
                            value; // 입력값을 currentMessageContent에 저장
                      },
                      decoration: InputDecoration(
                        hintText: currentMessageContent.isEmpty
                            ? '문자의 내용을 입력해주세요'
                            : null,
                        filled: true,
                        fillColor: backgroundColor,
                        hoverColor: inputHoverColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: navigateToCheckImage,
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
                        onPressed: () {
                          if ((messageContentController.text) == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('메시지를 입력하세요')),
                            );
                          } else {
                            // 메시지 내용이 비어있지 않다면
                            navigateToInputPhoneNumber();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: deepBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          '연락처 입력',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
