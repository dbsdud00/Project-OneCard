import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecard/model/user.dart';
import 'package:onecard/module/btn_elevated.dart';
import 'package:onecard/module/rank_list_item.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/pages/game_page.dart';
import 'package:onecard/pages/rank_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.updateAuthUser});
  final Function(User? user) updateAuthUser;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late User? _authUser;
  final firestore = FirebaseFirestore.instance;
  var player = GameUser();
  void getUser() async {
    final usercol =
        FirebaseFirestore.instance.collection("user").doc(_authUser!.uid);
    var checking = await usercol.get(); //받아오는 방식이므로 await필요(아래거 실행늦게 하게 하려면)
    if (checking.exists) {
      //존재성 확인하는 부분.
      await usercol.get().then((value) => {
            //값을 읽으면서, 그 값을 변수로 넣는 부분
            player.nickname = value['nickname'],
            player.money = value['money']
          });
      debugPrint("플레이어닉네임 : ${player.nickname}");
      debugPrint("플레이어닉네임 : $player");
      setState(() {});
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(//확인하기위한 snackbar
          const SnackBar(
        content: Text('wrong code'),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  void initState() {
    // login 된 사용자 정보를 firebaseAuth 에 요청
    _authUser = FirebaseAuth.instance.currentUser;
    getUser();
    super.initState();
  }

  // getUser() async {
  //   debugPrint("-------------로그인 유저 ------------- : $_authUser");
  //   var result = await firestore.collection("user").doc(_authUser!.uid).get();
  //   debugPrint("-=------------------결과 : ----------------${result.data()}");
  //   Map<String, dynamic>? testData = result.data();
  //   debugPrint(
  //       "-=------------------결과 : ----------------${testData!['nickname']}");
  //   player = GameUser(nickname: testData['nickname'], money: testData['money']);
  // }

  // GameUser player = GameUser(getUser());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/MainPage_bg.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
              child: Center(
                child: Column(
                  children: [
                    textOutline(textValue: "CASINO", fontSize: 64),
                    textOutline(
                        textValue: "OneCard",
                        fontSize: 24,
                        innerColor: const Color.fromARGB(255, 220, 220, 220)),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "PLAYER",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    player.nickname!,
                    style: const TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 53, 80, 255)),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                var result = await FirebaseAuth.instance.signOut();
                widget.updateAuthUser(null);
                debugPrint("로그아웃 authUser 리셋 : $_authUser");
                player = GameUser();
                debugPrint("로그아웃 playerDto 리셋 : ${player.toString()}");
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Logout"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  elevatedBtn(context,
                      btnText: "Single", width: 150, page: const GamePage()),
                  elevatedBtn(context,
                      btnText: "multi", width: 150, page: const GamePage()),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "MONEY",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const Text(
                  ":",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${player.money}\$",
                    style: const TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 212, 163, 17)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Rank",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: 300,
                    height: 330,
                    child: Column(
                      children: [
                        rank(
                          rank: 1,
                          userName: "test01",
                          money: 10000,
                          rankColor: const Color.fromARGB(255, 212, 163, 17),
                          fontSize: 35,
                        ),
                        rank(
                          rank: 2,
                          userName: "test02",
                          money: 5000,
                          rankColor: const Color.fromARGB(255, 144, 144, 144),
                          fontSize: 32,
                        ),
                        rank(
                            rank: 3,
                            userName: "test02",
                            money: 5000,
                            rankColor: const Color.fromARGB(255, 116, 95, 83),
                            fontSize: 30),
                        rank(rank: 4, userName: "test02", money: 5000),
                        rank(rank: 5, userName: "test02", money: 5000),
                        GestureDetector(
                          onTap: () {
                            // getUser();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RankPage(),
                            ));
                          },
                          child: const Text("more ▼"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
