import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int? selectedIndex; // 선택된 항목의 인덱스를 저장하는 변수
  List<int> items = List.generate(10, (index) => index); // 10개의 항목 생성

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600; // 화면 너비가 600 이상일 경우 웹으로 간주

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          width: isWeb ? 500 : screenSize.width * 0.9,
          height: isWeb ? screenSize.height * 0.7 : screenSize.height * 0.8,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = selectedIndex == index ? null : index;
                  });
                },
                child: MessageListItem(
                  isSelected: selectedIndex == index,
                  onDelete: () {
                    setState(() {
                      items.removeAt(index); // 선택된 항목 삭제
                      selectedIndex = null; // 선택 해제
                    });
                  },
                  onViewRecipients: () {
                    _showRecipientsDialog(context); // 수신자 리스트 팝업 표시
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // 수신자 리스트 팝업 다이얼로그
  void _showRecipientsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("수신자 명단"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // 예시로 5명의 수신자 리스트
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text("수신자 ${index + 1}"),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text("닫기"),
            ),
          ],
        );
      },
    );
  }
}

class MessageListItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onDelete;
  final VoidCallback onViewRecipients;

  MessageListItem({
    required this.isSelected,
    required this.onDelete,
    required this.onViewRecipients,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      height: isSelected ? 300 : 60, // 선택된 상태일 때 높이를 더 크게 설정
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '', // 빈 텍스트로 설정하여 내용 제거
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Icon(isSelected ? Icons.expand_less : Icons.expand_more, color: Colors.black54),
            ],
          ),
          Spacer(),
          if (isSelected) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onViewRecipients, // 수신자 리스트 보기 버튼
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    '수신자 명단 보기',
                    style: TextStyle(color: deepBlueColor),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: normalBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    '삭제',
                    style: TextStyle(color:deepBlueColor),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
