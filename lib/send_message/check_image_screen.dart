import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:precapstone/const/server_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckImageScreen extends StatefulWidget {
  final VoidCallback navigateToWriteMessage;
  final VoidCallback navigateToCrateImage;

  const CheckImageScreen({
    super.key,
    required this.navigateToCrateImage,
    required this.navigateToWriteMessage,
  });

  @override
  State<CheckImageScreen> createState() => _CheckImageScreenState();
}

class _CheckImageScreenState extends State<CheckImageScreen> {
  String currentImgUrl = '';

  @override
  void initState() {
    super.initState();
    _loadCurrentImgUrl(); // SharedPreferences에서 URL 로드
  }

  Future<void> _loadCurrentImgUrl() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentImgUrl = prefs.getString('currentImgUrl')!;
    });
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
                      constraints: BoxConstraints(
                        minHeight: isWeb
                            ? screenSize.height * 0.5
                            : screenSize.height * 0.7,
                      ),
                      child: Center(
                        child: Image.network(
                          'http://${address}/${currentImgUrl}',
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Text(
                            '이미지를 불러올 수 없습니다.',
                            style: TextStyle(color: normalRedColor),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: widget.navigateToCrateImage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: deepBlueColor,
                          backgroundColor: normalBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          '이전으로',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: widget.navigateToWriteMessage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: deepBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: const Text(
                          '문자 작성 하기',
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
