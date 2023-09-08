import 'package:flutter/material.dart';
import 'package:onecard/model/user.dart';
import 'package:onecard/module/rank_list_item.dart';
import 'package:onecard/module/text_outline.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final List<User> rankList = [
    User(nickname: "test01", money: 1005),
    User(nickname: "test02", money: 1004),
    User(nickname: "test03", money: 1003),
    User(nickname: "test04", money: 1002),
    User(nickname: "test05", money: 1001),
    User(nickname: "test06", money: 1000),
    User(nickname: "test05", money: 1001),
    User(nickname: "test06", money: 1000),
    User(nickname: "test05", money: 1001),
    User(nickname: "test06", money: 1000),
    User(nickname: "test05", money: 1001),
    User(nickname: "test06", money: 1000),
    User(nickname: "test05", money: 1001),
    User(nickname: "test06", money: 1000),
  ];
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
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 30),
              child: Center(
                child: Column(
                  children: [
                    textOutline(
                        textValue: "CASINO",
                        fontSize: 64,
                        innerColor: const Color.fromARGB(255, 212, 163, 17)),
                    textOutline(
                        textValue: "OneCard",
                        fontSize: 24,
                        innerColor: const Color.fromARGB(255, 220, 220, 220)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      width: double.infinity,
                      height: 500,
                      child: ListView.builder(
                        itemCount: rankList.length,
                        itemBuilder: (context, index) => rank(
                            rank: index + 1,
                            userName: rankList[index].nickname,
                            money: rankList[index].money,
                            rankColor: index == 0
                                ? const Color.fromARGB(255, 212, 163, 17)
                                : (index == 1
                                    ? const Color.fromARGB(255, 144, 144, 144)
                                    : (index == 2
                                        ? const Color.fromARGB(255, 116, 95, 83)
                                        : null))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
