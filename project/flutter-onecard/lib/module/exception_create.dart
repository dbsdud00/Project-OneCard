class MyException implements Exception {
  final String? msg;

  const MyException([this.msg]); // []: optional positional parameters

  @override
  String toString() => msg ?? 'MyException';
  // ?? : conditional expressions. 앞에꺼가 null 아니면 고거 리턴, 아니면 뒤에꺼
}
