import 'package:flutter/material.dart';
import 'package:precapstone/send_message/create_image_screen.dart';
import 'package:precapstone/send_message/first_screen.dart';
import '../message_history/second_screen.dart';
import '../my_info/third_screen.dart';
import '../const/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 변경
    });
  }

  void _navigateToCreateImagePage() {
    setState(() {
      _selectedIndex = 3; // 이미지 생성 페이지로 이동
    });
  }

  void _navigateToSendMessagePage() {
    setState(() {
      _selectedIndex = 0; // 문자 보내기 페이지로 이동
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlueColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0), // 텍스트를 아래로 내림
          child: Text(
            _getAppBarTitle(_selectedIndex),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: whiteColor),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          FirstPage(navigateToCrateImage: _navigateToCreateImagePage), // 콜백 전달
          const SecondPage(),
          const ThirdPage(),
          CreateImagePage(
            navigateToSendMessage: _navigateToSendMessagePage,
          ), // 콜백 전달
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: '첫 번째',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '두 번째',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '세 번째',
          ),
        ],
        currentIndex: _selectedIndex == 3 ? 0 : _selectedIndex,
        selectedItemColor: deepBlueColor,
        onTap: _onItemTapped,
        showSelectedLabels: false, // 선택된 항목의 라벨 숨김
        showUnselectedLabels: false, // 선택되지 않은 항목의 라벨 숨김
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return '문자 보내기';

      case 1:
        return '문자 기록 조회';
      case 2:
        return '내 정보';
      case 3:
        return '이미지 생성';
      default:
        return '';
    }
  }
}
