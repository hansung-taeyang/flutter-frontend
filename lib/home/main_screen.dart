import 'package:flutter/material.dart';
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

// 3개의 다른 화면 정의
  static final List<Widget> _screens = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DEEP_BLUE_COLOR,
          title: Padding(
          padding: const EdgeInsets.only(top: 10.0), // 텍스트를 아래로 내림
          child: Text(
            _getAppBarTitle(_selectedIndex),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: WHITE_COLOR
            ),
          ),
        ),
      ),

      body: _screens[_selectedIndex], // 현재 선택된 화면 보여줌
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF5F5F5),
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
        currentIndex: _selectedIndex,
        selectedItemColor: DEEP_BLUE_COLOR,
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
      default:
        return '앱';
    }
  }
}
