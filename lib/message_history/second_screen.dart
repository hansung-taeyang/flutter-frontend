import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int? selectedIndex; // 선택된 항목의 인덱스를 저장하는 변수
  List<int> items = List.generate(30, (index) => index); // 30개의 항목 생성
  // 리스트 수자는 0~29 까지 총 30개의 항목

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
          width: isWeb ? 500 : screenSize.width * 0.9, // 웹과 앱 화면 크기에 따른 너비 조정
          height: isWeb ? screenSize.height * 0.7 : screenSize.height * 0.8, // 높이 조정
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(16),
          child: ListView.builder(   //리스트의 항목 수만큼 MessageListItem 위젯 반복 렌더링
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = selectedIndex == index ? null : index;
                      });
                    },
                    child: MessageListItem(),
                  ),
                  if (selectedIndex == index)
                    _buildActionBox(index), // 삭제 버튼 클릭 시 해당 인덱스를 전달
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // 수신자 명단 보기와 삭제 버튼을 포함한 액션 박스
  Widget _buildActionBox(int index) { //선택된 항목 아래에 나타나는 컨테이너
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              // 수신자 명단 보기 기능 추가
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE3E8FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              '수신자 명단 보기',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                items.removeAt(index); // 선택된 항목 삭제
                selectedIndex = null; // 선택 해제
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              '삭제',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '', // 빈 텍스트로 설정하여 내용 제거
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Icon(Icons.expand_more, color: Colors.black54),
        ],
      ),
    );
  }
}
