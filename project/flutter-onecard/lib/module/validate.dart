import 'package:flutter/material.dart';

class CheckValidate {
  String? emailCheck({
    required String email,
    required FocusNode focusNode,
  }) {
    if (email.isEmpty) {
      focusNode.requestFocus();
      return "이메일을 입력해 주세요";
    } else {
      const pattern =
          r"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        focusNode.requestFocus();
        return "이메일 형식이 잘못되었습니다.";
      }
    }
    return null;
  }

  String? passwordCheck({
    required String password,
    required FocusNode focusNode,
  }) {
    if (password.isEmpty) {
      focusNode.requestFocus();
      debugPrint("비번입력해주세요");
      return "비밀번호를 입력해 주세요";
    } else {
      const pattern =
          r"^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(password)) {
        focusNode.requestFocus();
        debugPrint("비번제대로입력해주세요");
        return "비밀번호는 특수문자, 영문자, 숫자 포함하여 8 ~ 15 자리로 입력하세요";
      }
    }
    return null;
  }

  String? rePasswordCheck({
    required String password,
    required String rePassword,
    required FocusNode focusNode,
  }) {
    if (rePassword.isEmpty) {
      focusNode.requestFocus();
      return "비밀번호를 입력해 주세요";
    } else {
      if (rePassword != password) {
        focusNode.requestFocus();
        return "비밀번호가 다릅니다.";
      }
    }
    return null;
  }

  String? nickNameCheck({
    required String nickname,
    required FocusNode focusNode,
  }) {
    if (nickname.isEmpty) {
      focusNode.requestFocus();
      return "닉네임을 입력해 주세요";
    } else {
      if (nickname.length > 10 || nickname.length < 2) {
        focusNode.requestFocus();
        return "닉네임은 2 ~ 10 자리로 입력해 주세요.";
      }
    }
    return null;
  }
}
