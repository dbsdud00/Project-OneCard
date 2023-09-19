import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecard/module/exception_create.dart';

class AuthManage {
  /// 회원가입
  static Future<bool> createUser(
      String email, String pw, String nickname) async {
    final db = FirebaseFirestore.instance;
    try {
      // final citiesRef = db.collection("user");

// Create a query against the collection.

      Future<bool> nickResult = db
          .collection("user")
          .where("nickname", isEqualTo: nickname)
          .get()
          .then(
        (querySnapshot) {
          debugPrint("Successfully completed");
          if (querySnapshot.docs.isNotEmpty) {
            return false;
          }
          return true;
        },
        onError: (e) => debugPrint("Error completing: $e"),
      );
      if (await nickResult) {
        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pw,
        );
        if (credential.user != null) {
          await FirebaseFirestore.instance
              .collection("user")
              .doc(credential.user!.uid)
              .set({
            "email": email,
            "nickname": nickname,
            "money": 1000,
          });
          return true;
        }
      } else {
        throw const MyException("중복된 닉네임 입니다.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const MyException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw const MyException('이미 존재하는 이메일 입니다.');
      } else {
        throw const MyException("another firebaseAuthException");
      }
    } catch (e) {
      throw const MyException("fail_validation");
    }
    // authPersistence(); // 인증 영속
    return false;
  }

  /// 로그인
  static Future<bool> signIn(String email, String pw) async {
    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: pw,
      // );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "cyy0519@naver.com",
        password: "!Korea8080",
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const MyException('없는 계정입니다.');
      } else if (e.code == 'wrong-password') {
        throw const MyException('비밀번호가 틀렸습니다.');
      } else {
        throw MyException(e.toString());
      }
    } catch (e) {
      throw MyException(e.toString());
    }
    // authPersistence(); // 인증 영속
  }

  /// 로그아웃
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// 회원가입, 로그인시 사용자 영속
  void authPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  /// 유저 삭제
  Future<void> deleteUser(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }

  /// 현재 유저 정보 조회
  User? getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final name = user.displayName;
      final email = user.email;
      final photoUrl = user.photoURL;

      // Check if user's email is verified
      final emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      final uid = user.uid;
    }
    return user;
  }

  /// 공급자로부터 유저 정보 조회
  User? getUserFromSocial() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.cpm, etc.)
        final provider = providerProfile.providerId;

        // UID specific to the provider
        final uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
      }
    }
    return user;
  }

  /// 유저 이름 업데이트
  Future<void> updateProfileName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(name);
  }

  /// 유저 url 업데이트
  Future<void> updateProfileUrl(String url) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(url);
  }

  /// 비밀번호 초기화 메일보내기
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.setLanguageCode("kr");
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
