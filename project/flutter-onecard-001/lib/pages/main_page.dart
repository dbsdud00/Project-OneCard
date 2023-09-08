import 'package:flutter/material.dart';
import 'package:onecard/module/btn_elevated.dart';
import 'package:onecard/module/rank_list_item.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/pages/game_page.dart';
import 'package:onecard/pages/rank_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "PLAYER",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "test01",
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 53, 80, 255)),
                  ),
                ),
              ],
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "MONEY",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "10000\$",
                    style: TextStyle(
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
