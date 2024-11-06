import 'package:flutter/material.dart';
import 'package:precapstone/const/colors.dart';
import 'package:precapstone/const/server_address.dart';

class CheckImagePage extends StatefulWidget {
  final String? imageUrl;
  final VoidCallback navigateToWriteMessage;
  final VoidCallback navigateToCrateImage;

  const CheckImagePage({
    super.key,
    this.imageUrl,
    required this.navigateToCrateImage,
    required this.navigateToWriteMessage,
  });

  @override
  State<CheckImagePage> createState() => _CheckImagePageState();
}

class _CheckImagePageState extends State<CheckImagePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screenSize = MediaQuery.of(context).size;
        var isWeb = screenSize.width > 600;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: isWeb ? 500 : double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: screenSize.height * 0.6,
                          ),
                          child: widget.imageUrl != null
                              ? Image.network(
                                  'http://$address:3000${widget.imageUrl!}',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Text(
                                    '이미지를 불러올 수 없습니다.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : const Text('이미지가 없습니다.'),
                        ),
                        const SizedBox(height: 110),
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
                      ],
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