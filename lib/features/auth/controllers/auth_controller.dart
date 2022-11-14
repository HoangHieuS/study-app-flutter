import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../widgets/core/commom/app_logger.dart';
import '../../../firebase/references.dart';
import '../../../widgets/dialog/dialog_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  void signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: _authAccount.accessToken,
          idToken: _authAccount.idToken,
        );

        await _auth.signInWithCredential(credential);
        saveUser(account);
      }
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  void saveUser(GoogleSignInAccount user) async {
    userRF.doc(user.email).set({
      'email': user.email,
      'name': user.displayName,
      'profilePic': user.photoUrl,
    });
  }

  void navigateToIntroduction() {
    Get.offAllNamed('/introduction');
  }

  void showLoginAleartDialogue() {
    Get.dialog(
      Dialogs.questionStartDialogue(
        onTap: () {
          Get.back();

        },
      ),
      barrierDismissible: false,
    );
  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }
}
