import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecard/module/input_form_field.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/module/validate.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _rePasswordFocus = FocusNode();
  final _nickNameFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailValue = "";
  String _passwordValue = "";
  String _rePasswordValue = "";
  String _nickNameValue = "";
  @override
  Widget build(BuildContext context) {
    return Column(
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
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              body: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textOutline(textValue: "CASINO", fontSize: 64),
                      textOutline(
                        textValue: "OneCard",
                        fontSize: 24,
                        innerColor: const Color.fromARGB(255, 220, 220, 220),
                      )
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
              resizeToAvoidBottomInset: false,
              backgroundColor:
                  const Color.fromARGB(0, 255, 255, 255), // 배경색을 투명으로 설정
              body: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      inputFormField(
                        focusNode: _emailFocus,
                        validator: (value) => CheckValidate()
                            .emailCheck(email: value!, focusNode: _emailFocus),
                        setValue: (value) => _emailValue = value,
                        hintText: "이메일",
                        helpText: " ",
                      ),
                      inputFormField(
                        focusNode: _passwordFocus,
                        setValue: (value) => _passwordValue = value,
                        validator: (value) => CheckValidate().passwordCheck(
                            password: value!, focusNode: _passwordFocus),
                        helpText: " ",
                        hintText: "비밀번호",
                      ),
                      inputFormField(
                        focusNode: _rePasswordFocus,
                        setValue: (value) => _rePasswordValue = value,
                        validator: (value) => CheckValidate().rePasswordCheck(
                            password: _passwordValue,
                            rePassword: value!,
                            focusNode: _rePasswordFocus),
                        helpText: " ",
                        hintText: "비밀번호 확인",
                      ),
                      inputFormField(
                        focusNode: _nickNameFocus,
                        setValue: (value) => _nickNameValue = value,
                        validator: (value) => CheckValidate().nickNameCheck(
                            nickname: value!, focusNode: _nickNameFocus),
                        helpText: " ",
                        hintText: "닉네임",
                      ),
                      joinBtn(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget joinBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 24, 147, 85),
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          _formKey.currentState?.validate();
          try {
            var result =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailValue,
              password: _passwordValue,
            );
            debugPrint("-------회원가입 결과-----------$result");
            // widget.updateAuthUser(result.user);
            // email, password 이외의 회원정보를 저장하려면 fireStore 에 저장을 해주어야 한다.

            if (result.user != null) {
              await FirebaseFirestore.instance
                  .collection("user")
                  .doc(result.user!.uid)
                  .set({
                "email": result.user!.email,
                "nickname": _nickNameValue,
                "money": 0,
              });
              if (!mounted) return;
              Navigator.pop(context);
            }
          } on FirebaseException catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message!)));
          }
        },
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            "회원가입",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
