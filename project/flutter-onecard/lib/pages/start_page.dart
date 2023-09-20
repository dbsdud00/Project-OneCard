import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onecard/module/btn_elevated.dart';
import 'package:onecard/module/on_back_key.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/pages/game_page.dart';
import 'package:onecard/pages/join_page.dart';
import 'package:onecard/pages/login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  bool isStart = false;

  /// _authUser state 선언
  late User? _authUser;

  @override
  void initState() {
    // login 된 사용자 정보를 firebaseAuth 에 요청
    _authUser = FirebaseAuth.instance.currentUser;
    isStart = false;
    super.initState();
  }

  void updateAuthUser(User? user) {
    debugPrint("########## 업데이트 AuthUser : $user");
    setState(() {
      _authUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackKey(
          context: context,
          title: "게임을 종료하시겠습니까?",
          yes: () async {
            if (!mounted) return;
            SystemNavigator.pop();
          }),
      child: Column(
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
                body: GestureDetector(
                  onTap: () {
                    setState(() {
                      isStart = false;
                    });
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textOutline(textValue: "CASINO", fontSize: 64),
                        textOutline(
                            textValue: "OneCard",
                            fontSize: 24,
                            innerColor:
                                const Color.fromARGB(255, 220, 220, 220)),
                      ],
                    ),
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
                body: !isStart
                    ? GestureDetector(
                        onTap: () async {
                          debugPrint("click to start");
                          if (_authUser != null) {
                            await FirebaseAuth.instance.signOut();
                            _authUser = FirebaseAuth.instance.currentUser;
                          }
                          isStart = true;
                          debugPrint("유저정보 : $_authUser");
                          setState(() {});
                        },
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('images/Intro_img.png'),
                                height: 200,
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  "click to start",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 235, 50, 50)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            elevatedBtn(
                              context,
                              btnText: "Login",
                              onPressed: const LoginPage(),
                            ),
                            elevatedBtn(
                              context,
                              btnText: "Join",
                              bgColor: const Color.fromARGB(255, 28, 201, 114),
                              onPressed: const JoinPage(),
                            ),
                            elevatedBtn(
                              context,
                              btnText: "GuestPlay",
                              bgColor: const Color.fromARGB(255, 93, 93, 93),
                              onPressed: const GamePage(),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
