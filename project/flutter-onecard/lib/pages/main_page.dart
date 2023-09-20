import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onecard/model/user.dart';
import 'package:onecard/module/btn_elevated.dart';
import 'package:onecard/module/btn_elevated_func.dart';
import 'package:onecard/module/on_back_key.dart';
import 'package:onecard/module/rank_list_item.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/module/toast.dart';
import 'package:onecard/pages/game_page.dart';
import 'package:onecard/pages/login_page.dart';
import 'package:onecard/pages/rank_page.dart';
import 'package:onecard/pages/start_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.gameResult});
  final bool? gameResult;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late User? _authUser;
  final firestore = FirebaseFirestore.instance;
  var player = GameUser();
  late FToast fToast;
  void getUser(User? authUser) async {
    final usercol =
        FirebaseFirestore.instance.collection("user").doc(authUser!.uid);
    var checking = await usercol.get(); //받아오는 방식이므로 await필요(아래거 실행늦게 하게 하려면)

    if (checking.exists) {
      //존재성 확인하는 부분.
      await usercol.get().then((value) => {
            //값을 읽으면서, 그 값을 변수로 넣는 부분
            player.nickname = value['nickname'],
            player.money = value['money']
          });
      debugPrint("플레이어닉네임 : ${player.nickname}");
      debugPrint("플레이어 돈 : ${player.money}");
      if (widget.gameResult != null) {
        int moneyTemp = player.money!;
        if (widget.gameResult!) {
          player.money = moneyTemp + 1000;
          customToast("승리(1000\$를 얻었습니다)", fToast);
        } else {
          player.money = moneyTemp - 1000;
          customToast("패배(1000\$를 잃었습니다.)", fToast);
        }
      }
      if (player.money! < 1000) {
        debugPrint("돈없음");

        player.money = 1000;
        customToast("가진 돈이 없어 \n 1000\$ 기부 받았습니다.", fToast);
      }
      await firestore.runTransaction((transaction) async {
        transaction.update(usercol, {"money": player.money});
      }).then(
        (value) => debugPrint("충전됨"),
        onError: (e) => debugPrint("Error updating document $e"),
      );
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
    fToast = FToast();
    fToast.init(context);
    Future.delayed(const Duration(milliseconds: 1000), () {
      // if (widget.gameResult != null) {
      //   if (widget.gameResult!) {
      //     customToast("승리(1000\$를 얻었습니다)", fToast);
      //   } else {
      //     customToast("패배(1000\$를 잃었습니다.)", fToast);
      //   }
      // }
    });
    _authUser = FirebaseAuth.instance.currentUser;
    getUser(_authUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackKey(
          context: context,
          title: "게임을 종료하시겠습니까? 자동으로 로그아웃 됩니다.",
          yes: () async {
            await FirebaseAuth.instance.signOut();
            if (!mounted) return;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StartPage()),
                (route) => false);
          }),
      child: Container(
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
                      player.nickname ?? "none",
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 53, 80, 255)),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => onBackKey(
                    context: context,
                    title: "로그아웃 하시겠습니까? 로그인 페이지로 돌아갑니다.",
                    yes: () async {
                      await FirebaseAuth.instance.signOut();
                      debugPrint("로그아웃 authUser 리셋 : $_authUser");
                      player = GameUser();
                      debugPrint("로그아웃 playerDto 리셋 : ${player.toString()}");
                      // if (!mounted) return;
                      // Navigator.pop(context);

                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false);
                    }),

                // async {
                //   await FirebaseAuth.instance.signOut();
                //   debugPrint("로그아웃 authUser 리셋 : $_authUser");
                //   player = GameUser();
                //   debugPrint("로그아웃 playerDto 리셋 : ${player.toString()}");
                //   if (!mounted) return;
                //   Navigator.pop(context);
                // },
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
                    elevatedBtn(
                      context,
                      btnText: "Single",
                      width: 150,
                      onPressed: GamePage(player: player),
                    ),
                    elevatedBtnFunc(
                      context,
                      btnText: "multi",
                      width: 150,
                    ),
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
                      "${player.money ?? 0}\$",
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 212, 163, 17)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 300,
                            child: StreamBuilder(
                              stream: firestore
                                  .collection('user')
                                  .orderBy('money', descending: true)
                                  .limit(5)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return rank(
                                        rank: index + 1,
                                        userName: snapshot.data!.docs[index]
                                            ['nickname'],
                                        money: snapshot.data!.docs[index]
                                            ['money'],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // getUser();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RankPage(),
                              ));
                            },
                            child: const Text(
                              "more ▼",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
