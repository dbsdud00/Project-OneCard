import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecard/module/input_form_field.dart';
import 'package:onecard/module/text_outline.dart';
import 'package:onecard/module/validate.dart';
import 'package:onecard/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.updateAuthUser});
  final Function(User? user) updateAuthUser;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _emailValue = "";
  String _passwordValue = "";
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
                          innerColor: const Color.fromARGB(255, 220, 220, 220))
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
                        hintText: "email",
                        helpText: " ",
                      ),
                      inputFormField(
                        focusNode: _passwordFocus,
                        setValue: (value) => _passwordValue = value,
                        validator: (value) => CheckValidate().passwordCheck(
                            password: value!, focusNode: _passwordFocus),
                        helpText: " ",
                        hintText: "password",
                      ),
                      loginBtn(),
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

  Widget loginBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 124, 124),
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          _formKey.currentState?.validate();
          var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailValue,
            password: _passwordValue,
          );
          debugPrint("-------로그인결과-----------$result");
          await widget.updateAuthUser(result.user);
          // setState(() {});
          if (!mounted) return;
          // result.user != null ? true : false
          // Navigator.pop(context, 데이터) : 현재 화면이 닫힐때
          // 현재 화면을 열었던 곳으로 `데이터` 를 return
          if (result.user != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  MainPage(updateAuthUser: widget.updateAuthUser),
            ));
          }
        },
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            "로그인",
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
