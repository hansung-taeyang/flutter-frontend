import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.all(5.0), // 원하는 만큼 패딩을 설정
                  child: SizedBox(
                  width: 500,
                  height: 200,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.person
                          ),
                          Column(

                          )
                        ],
                      ),

                    ),

                  ),
                )
              ],
            ),
          )
          )
      )
    );
  }
}
