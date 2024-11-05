import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';

class FirstPage extends StatelessWidget {
  final VoidCallback navigateToCrateImage;

  const FirstPage({super.key, required this.navigateToCrateImage});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600; // 화면 너비 600px 이상일 경우 웹으로 간주
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15), // 테두리를 둥글게 만듦
              ),
              width: isWeb ? 500 : double.infinity,
              height: screenSize.height * 0.76,
              child: Column(children: [
                TextField(
                  maxLines: 19,
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: navigateToCrateImage,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: deepBlueColor,
                    backgroundColor: normalBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Text(
                    '다음으로',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
