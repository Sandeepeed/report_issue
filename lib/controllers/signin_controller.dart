import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:report_issue/screens/home_screens/home_page.dart';
import 'package:report_issue/utils/reusable_widgets.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController passoword = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  Future<void> signInWithGoogle() async {
    try {
      firebaseAuth.signInWithProvider(googleAuthProvider).then((value) async {
        user = value.user;
        if (user != null) {
          Get.to(() => const HomePage());
        } else {
          Get.showSnackbar(GetSnackBar(
            messageText: text(giveText: "Sign In Failed"),
          ));
        }
      });
    } catch (e) {
      printInfo(info: "${e}error");
    }
  }

  Future<void> signUpWithEmailPassword() async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.text, password: passoword.text)
          .then((value) {
        user = value.user;
        printInfo(info: user!.email!);
        if (user != null) {
          user!.updateDisplayName(name.text);
          Get.to(() => const HomePage());
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.showSnackbar(GetSnackBar(
            messageText: text(giveText: "The password provided is too weak")));
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(GetSnackBar(
            messageText:
                text(giveText: "The account already exists for that email.")));
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  Future<void> signInWithEmail() async {
    try {
      firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        user = value.user!;
        if (user != null) {
          Get.to(() => const HomePage());
        }
      });
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
