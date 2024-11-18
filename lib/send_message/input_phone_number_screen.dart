import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:precapstone/const/colors.dart';
import 'package:precapstone/const/message_content.dart';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:precapstone/const/server_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPhoneNumberPage extends StatefulWidget {
  final VoidCallback navigateToWriteMessage;
  final VoidCallback navigateToCrateImage;

  const InputPhoneNumberPage({
    super.key,
    required this.navigateToWriteMessage,
    required this.navigateToCrateImage,
  });

  @override
  _InputPhoneNumberPageState createState() => _InputPhoneNumberPageState();
}

class _InputPhoneNumberPageState extends State<InputPhoneNumberPage> {
  final TextEditingController senderController = TextEditingController();
  final TextEditingController receiverController = TextEditingController();

  Future<void> sendMessage() async {
    final url = Uri.parse('http://$address:3000/v1/message');

    if (currentSender == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('발신자를 입력하세요')),
      );
      return;
    }
    if (currentReceiverArray.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수신자를 입력하세요')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
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
          'content': currentMessageContent, // 메시지 내용
          'from': currentSender, // 발신자 번호
          'targetCount': currentReceiverArray.length, // 수신자 명수
          'targets': currentReceiverArray
              .map((receiver) => {
                    'to': receiver, // 각 수신자 번호
                  })
              .toList(), // 배열 변환
          'imageUrl': currentImgUrl, // 이미지 URL
        }),
      );
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        // 성공 시
        currentImgUrl = '';
        currentMessageContent = '';
        currentSender = '';
        currentReceiverArray = [];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("전송 완료"),
              content: const Text("메시지가 성공적으로 전송되었습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업 닫기
                    widget.navigateToCrateImage(); // CreateImagePage로 이동
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('서버 전송 실패')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  // 엑셀 파일 업로드
  Future<void> pickExcelFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null) {
        final fileBytes = result.files.single.bytes!;
        final excel = Excel.decodeBytes(fileBytes);

        final sheet = excel.tables[excel.tables.keys.first];
        if (sheet == null || sheet.rows.isEmpty) {
          _showSnackBar('엑셀 파일에 유효한 데이터가 없습니다.');
          return;
        }
        print(sheet.rows); // 모든 행의 데이터를 출력

        final phoneNumbers = sheet.rows
            .map((row) {
              if (row.isEmpty || row.first == null) return null;

              final cellValue = row.first?.value;

              // 셀 값이 숫자인 경우
              if (cellValue is num) {
                return '0${cellValue.toStringAsFixed(0)}'; // 문자열로 변환하고 '0' 추가
              } else {
                // 숫자가 아닌 경우 오류 처리
                throw Exception('엑셀에 숫자만 입력되어야 합니다. 오류 값: $cellValue');
              }
            })
            .where((number) => number != null && _isValidPhoneNumber(number))
            .toList();

        if (phoneNumbers.isEmpty) {
          _showSnackBar('엑셀 파일에 유효한 전화번호가 없습니다.');
          return;
        }

        setState(() {
          currentReceiverArray.addAll(phoneNumbers.cast<String>());
        });
        _showSnackBar('${phoneNumbers.length}개의 번호가 추가되었습니다.');
      }
    } catch (e) {
      _showSnackBar("엑셀 파일을 처리하는 중 오류가 발생했습니다: $e");
    }
  }

  // 전화번호 유효성 검사
  bool _isValidPhoneNumber(String number) {
    final regex = RegExp(r'^01[0-9]{8,9}$'); // 한국 전화번호 형식
    return regex.hasMatch(number);
  }

  // 스낵바 메시지 출력
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSenderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('발신자 확인'),
          content: Text(currentSender.isEmpty
              ? '발신자가 설정되지 않았습니다.'
              : '발신자: $currentSender'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  // 수신자 확인 및 삭제
  void _showReceiverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('수신자 확인'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: currentReceiverArray.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(currentReceiverArray[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        currentReceiverArray.removeAt(index);
                      });
                      Navigator.pop(context);
                      _showSnackBar('수신자가 삭제되었습니다.');
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

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
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: senderController,
                          maxLength: 11,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          decoration: InputDecoration(
                            hintText: '발신자 연락처를 입력하세요',
                            filled: true,
                            fillColor: backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: whiteColor,
                                backgroundColor: greyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () {
                                if (_isValidPhoneNumber(
                                    senderController.text)) {
                                  setState(() {
                                    currentSender = senderController.text;
                                    senderController.clear();
                                  });
                                  _showSnackBar('발신자가 저장되었습니다.');
                                } else {
                                  _showSnackBar('유효하지 않은 전화번호입니다.');
                                }
                              },
                              child: const Text("발신자 저장"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: whiteColor,
                                backgroundColor: greyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: _showSenderDialog,
                              child: const Text("발신자 확인"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '수신자 연락처',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: receiverController,
                          maxLength: 11,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            hintText: '수신자 연락처를 입력하세요',
                            filled: true,
                            fillColor: backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: whiteColor,
                                backgroundColor: greyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () {
                                if (_isValidPhoneNumber(
                                    receiverController.text)) {
                                  setState(() {
                                    currentReceiverArray
                                        .add(receiverController.text);
                                    receiverController.clear();
                                  });
                                  _showSnackBar('수신자가 추가되었습니다.');
                                } else {
                                  _showSnackBar('유효하지 않은 전화번호입니다.');
                                }
                              },
                              child: const Text("수신자 추가"),
                            ),
                            const SizedBox(width: 10),
                            if (isWeb)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: whiteColor,
                                  backgroundColor: greyColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                onPressed: pickExcelFile,
                                child: const Text("엑셀 파일 업로드"),
                              ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: whiteColor,
                                backgroundColor: greyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: _showReceiverDialog,
                              child: const Text("수신자 확인"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: widget.navigateToWriteMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: deepBlueColor,
                          backgroundColor: normalBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          "이전으로",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: sendMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: deepBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          '문자 전송',
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
