import 'package:flutter/material.dart';
import 'package:onecard/pages/login_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartPage(),
      theme: ThemeData(
        fontFamily: 'Yeongdeok',
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
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
              body: GestureDetector(
                onTap: () {
                  debugPrint("click to start");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                },
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('images/joker_color.png')),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "click to start",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    // return Scaffold(
    //   resizeToAvoidBottomInset: false, // 키보드가 올라와도 배경 이미지가 밀려 올라가지 않도록
    //   body: Column(
    // children: [
    //   Expanded(
    //     flex: 1,
    //     child: Container(
    //       decoration: const BoxDecoration(
    //         image: DecorationImage(
    //           fit: BoxFit.cover,
    //           image: AssetImage('images/StartPage_top.png'), // 배경 이미지
    //         ),
    //       ),
    //     ),
    //   ),
    //   Expanded(
    //     flex: 2,
    //     child: Container(
    //       decoration: const BoxDecoration(
    //         image: DecorationImage(
    //           fit: BoxFit.cover,
    //           image: AssetImage('images/StartPage_bottom.png'), // 배경 이미지
    //         ),
    //       ),
    //     ),
    //   ),
    // ],
    //   ),
    // );
  }
}
