import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:precapstone/const/server_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateImagePage extends StatefulWidget {
  final Function(String imageUrl) navigateToCheckImage;

  const CreateImagePage({
    super.key,
    required this.navigateToCheckImage,
  });

  @override
  _CreateImagePageState createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  String? selectStyle;
  String? imageUrl;
  String? imgStyle;
  Map<String, String> styles = {
    '미니멀리즘 스타일': 'minimalist',
    '플랫 디자인 스타일': 'flat design',
    '수채화 스타일': 'watercolor',
    '빈티지 스타일': 'vintage',
    '추상화 스타일': 'abstract',
    '선화 스타일': 'line art'
  };

  final TextEditingController bookCategoryController = TextEditingController();
  final TextEditingController bookIntroductionController =
      TextEditingController();

  Future<void> sendDataAndNavigate() async {
    final url = Uri.parse('http://$address:3000/v1/image/withLogin');
    final category = bookCategoryController.text;
    final intro = bookIntroductionController.text;

    if (selectStyle == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지 스타일을 선택하세요')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      // SharedPreferences에서 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('Token is missing!');
        return;
      }

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'prompt': intro + " " + category,
          'style': imgStyle,
        }),
      );
      Navigator.of(context).pop();
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final imageUrl = responseData['url'];
        if (imageUrl != null) {
          widget.navigateToCheckImage(imageUrl);
        } else {
          throw Exception("잘못된 응답: 이미지 URL을 찾을 수 없음");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('서버 전송 실패')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screenSize = MediaQuery.of(context).size;
        var isWeb = screenSize.width > 600;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: BoxConstraints(
                      minHeight: isWeb
                          ? screenSize.height * 0.5
                          : screenSize.height * 0.7,
                    ),
                    width: isWeb ? 500 : screenSize.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextInputSection(
                          title: '책 카테고리',
                          hintText: '예시) 판타지 소설, 과학 도서 (최대 20자)',
                          controller: bookCategoryController,
                          maxLength: 20,
                        ),
                        const SizedBox(height: 10),
                        _buildTextInputSection(
                          title: '책 소개',
                          hintText: '책 소개를 입력해주세요 (최대 3900자)',
                          controller: bookIntroductionController,
                          maxLength: 3900,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 10),
                        _buildDropdownSection(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: sendDataAndNavigate,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextInputSection({
    required String title,
    required String hintText,
    required TextEditingController controller,
    int maxLength = 100,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  Widget _buildDropdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '이미지 스타일',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectStyle,
            hint: const Text("이미지의 스타일을 선택해주세요"),
            underline: const SizedBox.shrink(),
            dropdownColor: whiteColor,
            items: styles.keys.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectStyle = newValue;
                imgStyle = styles[newValue];
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    bookIntroductionController.dispose();
    bookCategoryController.dispose();
    super.dispose();
  }
}
