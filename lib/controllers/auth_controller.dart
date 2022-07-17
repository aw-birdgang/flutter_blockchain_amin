import 'package:flutter_blockchain_amin/models/UserModel.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  bool isloadingSignIn = false;
  String errorMessage = "";

  UserModel? currentuserModel;

  AuthController () {
    UserModel? userModel = UserModel(
        email: 'birdgang@gmail.com',
        name: 'birdgang',
        pic: '',
        userId: 'birdgang');
    currentuserModel = userModel;
    notifyListeners();
  }

  Future<UserModel?> signIn(String email, String password) async {
    print("email : " + email + " , password : " + password);
    UserModel? userModel;
    isloadingSignIn = true;
    notifyListeners();
    try {
      // await _auth
      //     .signInWithEmailAndPassword(email: email, password: password)
      //     .then((value) async {
      //   // userModel = UserModel(
      //   //     email: value.user?.email,
      //   //     name: value.user?.displayName,
      //   //     pic: '',
      //   //     userId: value.user?.uid);
      //   isloadingSignIn = false;
      //   currentuserModel = userModel;
      //   notifyListeners();
      // });
      userModel = UserModel(
          email: 'birdgang@gmail.com',
          name: 'birdgang',
          pic: '',
          userId: 'birdgang');
      isloadingSignIn = false;
      currentuserModel = userModel;
      notifyListeners();
    } catch (e) {
      isloadingSignIn = false;
      errorMessage = e.toString();
      notifyListeners();
      print(e.toString());
    }
    return currentuserModel;
  }

  bool showpassword = false;
  onchangepasswordvisibility() {
    showpassword = !showpassword;
    notifyListeners();
  }

  Future SignOut() async {
    // await FirebaseAuth.instance.signOut();
    currentuserModel = null;
    notifyListeners();
  }
}
