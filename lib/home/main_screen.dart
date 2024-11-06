import 'package:flutter/material.dart';
import 'package:precapstone/send_message/check_image_screen.dart';
import 'package:precapstone/send_message/create_image_screen.dart';
import 'package:precapstone/send_message/write_message.dart';
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
  int _subIndex = 0; // 첫 번째 탭 내에서 페이지 구분
  String imageUrl = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 변경
    });
  }

  void _backToCreateImagePage() {
    setState(() {
      _subIndex = 0; // 이미지 생성 페이지로 이동
    });
  }

  void _goToWriteMessagePage() {
    setState(() {
      _subIndex = 2; // 문자 작성 페이지로 이동
    });
  }

  void _goToCheckImagePage(String imageUrl) {
    this.imageUrl = imageUrl;
    setState(() {
      _subIndex = 1; // 이미지 확인 페이지로 이동
    });
  }

  void _backToCheckImagePage() {
    setState(() {
      _subIndex = 1; // 이미지 확인 페이지로 이동
    });
  }

  Widget _getCurrentPage() {
    if (_selectedIndex == 0) {
      // 첫 번째 탭에서는 _subIndex에 따라 페이지 구분
      switch (_subIndex) {
        case 0:
          return CreateImagePage(navigateToCheckImage: _goToCheckImagePage);
        case 1:
          return CheckImagePage(
            imageUrl: imageUrl,
            navigateToWriteMessage: _goToWriteMessagePage,
            navigateToCrateImage: _backToCreateImagePage,
          );
        case 2:
          return WriteMessagePage(
            imageUrl: imageUrl,
            navigateToCheckImage: _backToCheckImagePage,
          );
        default:
          return CreateImagePage(navigateToCheckImage: _goToCheckImagePage);
      }
    } else if (_selectedIndex == 1) {
      return const SecondPage();
    } else {
      return const ThirdPage();
    }
  }

  String _getAppBarTitle() {
    if (_selectedIndex == 0) {
      // 첫 번째 탭에서 subIndex에 따라 타이틀 변경
      switch (_subIndex) {
        case 0:
          return '이미지 생성';
        case 1:
          return '이미지 확인';
        case 2:
          return '문자 작성';
        default:
          return '';
      }
    } else if (_selectedIndex == 1) {
      return '문자 기록 조회';
    } else if (_selectedIndex == 2) {
      return '내 정보';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlueColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0), // 텍스트를 아래로 내림
          child: Text(
            _getAppBarTitle(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: whiteColor),
          ),
        ),
      ),
      body: _getCurrentPage(),
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
        currentIndex: _selectedIndex,
        selectedItemColor: deepBlueColor,
        onTap: _onItemTapped,
        showSelectedLabels: false, // 선택된 항목의 라벨 숨김
        showUnselectedLabels: false, // 선택되지 않은 항목의 라벨 숨김
      ),
    );
  }
}
