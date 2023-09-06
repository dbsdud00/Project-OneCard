import 'package:flutter/material.dart';
import 'package:onecard/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Header
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/StartPage_top.png'), // 배경 이미지
              ),
            ),
            child: Scaffold(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'CASINO',
                          style: TextStyle(
                            fontSize: 64,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        // Solid text as fill.
                        const Text(
                          'CASINO',
                          style: TextStyle(
                            fontSize: 64,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'OneCard',
                          style: TextStyle(
                            fontSize: 26,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        // Solid text as fill.
                        const Text(
                          'OneCard',
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 220, 220, 220)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Body
        Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/StartPage_bottom.png'), // 배경 이미지
              ),
            ),
            child: Scaffold(
              backgroundColor:
                  const Color.fromARGB(0, 255, 255, 255), // 배경색을 투명으로 설정
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        height: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("구글로그인 탭");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 124, 124),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Google Login",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300,
                        height: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("게스트 플레이 탭");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 93, 93, 93),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Guest Play",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
