import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteMessageScreen extends StatelessWidget {
  final VoidCallback navigateToCheckImage;
  final VoidCallback navigateToInputPhoneNumber;
  final TextEditingController messageContentController =
      TextEditingController();

  WriteMessageScreen({
    super.key,
    required this.navigateToCheckImage,
    required this.navigateToInputPhoneNumber,
  });

  Future<void> _saveMessageContent(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentMessageContent', value);
  }

  Future<void> _loadMessageContent() async {
    final prefs = await SharedPreferences.getInstance();
    final savedContent = prefs.getString('currentMessageContent') ?? '';
    messageContentController.text = savedContent;
  }

  @override
  Widget build(BuildContext context) {
    // 메시지 내용을 SharedPreferences에서 로드
    _loadMessageContent();

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
                      controller: messageContentController,
                      maxLines: 19,
                      maxLength: 900,
                      onChanged: (value) {
                        _saveMessageContent(value); // SharedPreferences에 저장
                      },
                      decoration: InputDecoration(
                        hintText: '문자의 내용을 입력해주세요',
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
                          if (messageContentController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('메시지를 입력하세요')),
                            );
                          } else {
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
