import 'package:flutter/material.dart';
import 'package:precapstone/send_message/check_image_screen.dart';
import 'package:precapstone/send_message/create_image_screen.dart';
import 'package:precapstone/send_message/input_phone_number_screen.dart';
import 'package:precapstone/send_message/write_message_screen.dart';
import 'package:precapstone/message_record/record_query_screen.dart';
import 'package:precapstone/user_info/user_dashboard_screen.dart';
import 'package:precapstone/const/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _subIndex = 0; // 첫 번째 탭 내에서 페이지 구분

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

  void _goToCheckImagePage() {
    setState(() {
      _subIndex = 1; // 이미지 확인 페이지로 이동
    });
  }

  void _backToCheckImagePage() {
    setState(() {
      _subIndex = 1; // 이미지 확인 페이지로 이동
    });
  }

  void _goToInputPhoneNumberPage() {
    setState(() {
      _subIndex = 3; // 전화번호 입력 페이지로 이동
    });
  }

  void _backToWriteMessagePage() {
    setState(() {
      _subIndex = 2; // 문자 작성 페이지로 이동
    });
  }

  Widget _getCurrentPage() {
    if (_selectedIndex == 0) {
      // 첫 번째 탭에서는 _subIndex에 따라 페이지 구분
      switch (_subIndex) {
        case 0:
          return CreateImageScreen(navigateToCheckImage: _goToCheckImagePage);
        case 1:
          return CheckImageScreen(
            navigateToWriteMessage: _goToWriteMessagePage,
            navigateToCrateImage: _backToCreateImagePage,
          );
        case 2:
          return WriteMessageScreen(
            navigateToCheckImage: _backToCheckImagePage,
            navigateToInputPhoneNumber: _goToInputPhoneNumberPage,
          );
        case 3:
          return InputPhoneNumberScreen(
            navigateToWriteMessage: _backToWriteMessagePage,
            navigateToCrateImage: _backToCreateImagePage,
          );
        default:
          return CreateImageScreen(navigateToCheckImage: _goToCheckImagePage);
      }
    } else if (_selectedIndex == 1) {
      return const RecordQueryScreen();
    } else {
      return const UserDashboardScreen();
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
        case 3:
          return '전화번호 입력';
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
