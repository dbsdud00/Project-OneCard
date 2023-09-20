import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onecard/module/rank_list_item.dart';
import 'package:onecard/module/text_outline.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
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
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
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
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .orderBy('money', descending: true)
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
                                  money: snapshot.data!.docs[index]['money'],
                                );
                              },
                            );
                          }
                        },
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
