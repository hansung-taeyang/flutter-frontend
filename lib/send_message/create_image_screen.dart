import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';

class CreateImagePage extends StatefulWidget {
  final VoidCallback navigateToSendMessage;
  const CreateImagePage({super.key, required this.navigateToSendMessage});

  @override
  _CreateImagePageState createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  String? _selectedValue;

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
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '책의 장르를 입력해주세요',
                    filled: true,
                    fillColor: backgroundColor,
                    hoverColor: inputHoverColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 13,
                  decoration: InputDecoration(
                    hintText: '책 소개를 입력해주세요',
                    filled: true,
                    fillColor: backgroundColor,
                    hoverColor: inputHoverColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(15), // 테두리를 둥글게 만듦
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true, // 가로로 확장되도록 설정
                      value: _selectedValue,
                      hint: const Text("이미지의 스타일을 선택해주세요"),
                      underline: const SizedBox.shrink(), // 밑줄 제거
                      dropdownColor: whiteColor,
                      items: <String>[
                        '미니멀리즘',
                        '플랫 디자인',
                        '수채화',
                        '파스텔 톤',
                        '빈티지 스타일',
                        '선화',
                        '스케치 스타일'
                      ]
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),

                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: widget.navigateToSendMessage,
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
                      onPressed: widget.navigateToSendMessage,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: whiteColor,
                        backgroundColor: deepBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: const Text(
                        '이미지 생성하기',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
