import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isWeb = screenSize.width > 600; // 화면 너비 600px 이상일 경우 웹으로 간주

    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // 테두리를 둥글게 만듦
                ),
                width: isWeb ? 500 : double.infinity,
                height: screenSize.height * 0.76,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [



                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
