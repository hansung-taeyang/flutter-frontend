import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';

class WriteMessagePage extends StatelessWidget {
  String messageContent = '';
  final VoidCallback navigateToCheckImage;
  final Function(String) navigateToInputPhoneNumber;

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
                      maxLines: 19,
                      maxLength: 900,
                      controller: messageContentController
                        ..text =
                            messageContent.isNotEmpty ? messageContent : '',
                      decoration: InputDecoration(
                        hintText:
                            messageContent.isEmpty ? '문자의 내용을 입력해주세요' : null,
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
                          navigateToInputPhoneNumber(
                              messageContentController.text);
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
