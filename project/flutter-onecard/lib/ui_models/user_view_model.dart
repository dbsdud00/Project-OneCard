import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecard/model/user.dart';

class UserViewModel extends ChangeNotifier {
  var player = GameUser(money: 0, nickname: "");

  final firestore = FirebaseFirestore.instance;
  Future<bool> getUser(User? authUser) async {
    final usercol =
        FirebaseFirestore.instance.collection("user").doc(authUser!.uid);
    var checking = await usercol.get(); //받아오는 방식이므로 await필요(아래거 실행늦게 하게 하려면)
    if (checking.exists) {
      //존재성 확인하는 부분.
      await usercol.get().then((value) => {
            player.nickname = value['nickname'],
            player.money = value['money']
            //값을 읽으면서, 그 값을 변수로 넣는 부분
          });
      debugPrint("플레이어닉네임 : ${player.nickname}");
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
