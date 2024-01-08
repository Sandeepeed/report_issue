import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:report_issue/screens/home_screens/home_page.dart';
import 'package:report_issue/screens/login_screens/signin_screen.dart';

class MainController extends GetxService {
  FirebaseAuth auth = FirebaseAuth.instance;
  routing() {
    if (auth.currentUser != null) {
      return const HomePage();
    } else {
      return const SignInScreen();
    }
  }
}
