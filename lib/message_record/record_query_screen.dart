import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:precapstone/const/server_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordQueryScreen extends StatefulWidget {
  const RecordQueryScreen({super.key});

  @override
  _RecordQueryScreenState createState() => _RecordQueryScreenState();
}

class _RecordQueryScreenState extends State<RecordQueryScreen> {
  int? selectedIndex;
  List messages = [];
  List<int> messageIds = [];
  List<String> imageUrls = []; // 이미지 URL 리스트
  List<String> messageContents = [];
  List<String> createDates = [];
  List<String> targetCounts = [];

  @override
  void initState() {
    super.initState();
    fetchImages(); // 페이지 로드 시 이미지 불러오기
  }

  Future<void> fetchImages() async {
    try {
      // SharedPreferences에서 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('Token is missing!');
        return;
      }

      final response = await http.get(
        Uri.parse('http://$address/v1/message'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          messages = data['messages'] as List;

          imageUrls = messages
              .map((item) => 'http://$address${item["image"]}')
              .toList();

          messageContents = messages
              .map((item) => item["messageJson"]["content"] as String)
              .toList();

          createDates =
              messages.map((item) => item["sentAt"] as String).toList();

          targetCounts = messages
              .map((item) => item["messageJson"]["targetCount"].toString())
              .toList();

          messageIds = messages.map((item) => item["id"] as int).toList();
        });
      } else {
        print('Failed to load images. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching images: $e');
    }
  }

  Future<void> deleteQuery(int index) async {
    final url = Uri.parse('http://$address/v1/message/$index');

    try {
      // SharedPreferences에서 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('Token is missing!');
        return;
      }

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        print('Message deleted successfully');
      } else {
        print('Failed to delete message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while deleting message: $e');
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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: isWeb ? 500 : screenSize.width * 0.9,
                    height: isWeb
                        ? screenSize.height * 0.7
                        : screenSize.height * 0.75,
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: messages.isEmpty
                        ? const Center(
                            child: Text(
                              '메시지가 없습니다.',
                              style: TextStyle(
                                  fontSize: 16, color: normalGreyColor),
                            ),
                          )
                        : ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex =
                                        selectedIndex == index ? null : index;
                                  });
                                },
                                child: MessageListItem(
                                  imageUrl:
                                      imageUrls[index], // 각 항목에 이미지 URL 전달
                                  messageContent: messageContents[index],
                                  createDate: createDates[index],
                                  targetCount: targetCounts[index],
                                  messageId: messageIds[index],
                                  isSelected: selectedIndex == index,
                                  onDelete: () async {
                                    await deleteQuery(
                                        messageIds[index]); // 서버에서 삭제
                                    setState(() {
                                      messages
                                          .removeAt(index); // messages에서 직접 삭제

                                      // 동기화된 리스트도 업데이트
                                      imageUrls = messages
                                          .map((item) =>
                                              'http://$address${item["image"]}')
                                          .toList();
                                      messageContents = messages
                                          .map((item) => item["messageJson"]
                                              ["content"] as String)
                                          .toList();
                                      createDates = messages
                                          .map((item) =>
                                              item["sentAt"] as String)
                                          .toList();
                                      targetCounts = messages
                                          .map((item) => item["messageJson"]
                                                  ["targetCount"]
                                              .toString())
                                          .toList();
                                      messageIds = messages
                                          .map((item) => item["id"] as int)
                                          .toList();

                                      selectedIndex = null;
                                    });
                                  },
                                ),
                              );
                            },
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

class MessageListItem extends StatelessWidget {
  final String imageUrl; // 이미지 URL 추가
  final String messageContent;
  final String createDate;
  final String targetCount;
  final int messageId;
  final bool isSelected;
  final VoidCallback onDelete;

  const MessageListItem({
    super.key,
    required this.imageUrl,
    required this.messageContent,
    required this.createDate,
    required this.targetCount,
    required this.messageId,
    required this.isSelected,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                messageContent.length >= 15
                    ? messageContent.substring(0, 15) // 길이가 15자 이상일 때
                    : messageContent, // 15자 미만일 경우 전체 출력
                style: const TextStyle(fontSize: 16, color: blackColor),
              ),
              Icon(
                isSelected ? Icons.expand_less : Icons.expand_more,
                color: normalGreyColor,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (isSelected)
            Text(
              messageContent,
              style: const TextStyle(fontSize: 16, color: blackColor),
            ),
          const SizedBox(
            height: 10,
          ),
          if (isSelected)
            GestureDetector(
              onTap: () {
                // 이미지를 클릭하면 팝업 표시
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: InteractiveViewer(
                        // 이미지 확대/축소 가능
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain, // 비율 유지
                          errorBuilder: (context, error, stackTrace) =>
                              const Text(
                            '이미지를 불러올 수 없습니다.',
                            style: TextStyle(color: normalRedColor),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Text(
                    '이미지를 불러올 수 없습니다.',
                    style: TextStyle(color: normalRedColor),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          if (isSelected)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '수신 인원 : $targetCount\n문자 전송 날짜 : ${createDate.substring(0, 10)} \n문자 전송 시간 : ${createDate.substring(11, 19)}',
                  style: const TextStyle(fontSize: 13, color: blackColor),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    '삭제',
                    style: TextStyle(fontSize: 16, color: deepBlueColor),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
