import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';

class WriteMessagePage extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback navigateToCheckImage;

  const WriteMessagePage({
    super.key,
    this.imageUrl,
    required this.navigateToCheckImage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screenSize = MediaQuery.of(context).size;
        var isWeb = screenSize.width > 600;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: isWeb ? 500 : double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          maxLines: 19,
                          maxLength: 900,
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
