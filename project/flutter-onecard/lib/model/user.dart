class GameUser {
  String? nickname;
  int? money;
  GameUser({
    this.nickname,
    this.money,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["nickname"] = nickname;
    data["money"] = money;
    return data;
  }

  GameUser.fromJson(Map<String, dynamic> json) {
    nickname = json["nickname"];
    money = json["money"];
  }

  @override
  String toString() {
    var result = """
      $nickname,
      $money,
      """;
    return result;
  }
}

// class Todo {
//   int? id;
//   String sdate;
//   String stime;
//   String content;
//   bool complete;

//   Todo({
//     this.id,
//     required this.sdate,
//     required this.stime,
//     required this.content,
//     required this.complete,
//   });

//   /// Map 자료형은 key, value 가 쌍으로 구성된 데이터 type
//   /// SQL Lite DB table 에 insert 를 하기 위해서는 실제 데이터를 Map<> type 으로 변환을 시켜야 한다.
//   Map<String, Object?> toMap() {
//     return {
//       // "id": id,
//       "sdate": sdate,
//       "stime": stime,
//       "content": content,
//       "complete": complete ? 1 : 0
//     };
//   }
// }
