import 'package:flutter/material.dart';
import 'package:flutter_blockchain_amin/shared/helper/prefer_helper.dart';
import 'package:provider/provider.dart';

import '../../../controllers/menu_controller.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/UserModel.dart';
import '../../../shared/components/default_button.dart';
import '../../../shared/components/default_text_form.dart';

class LoginForm extends StatelessWidget {
  var text_emailcontroller = TextEditingController();
  var text_passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login Screen",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
          defaultTextFormField(
            controller: text_emailcontroller,
            inputtype: TextInputType.emailAddress,
            hinttext: "Email",
            onvalidate: (value) {
              if (value!.isEmpty) return "email must not be empty";
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<AuthController>(builder: (context, authcontroller, child) {
            return defaultTextFormField(
              suffixIcon: InkWell(
                child: Icon(
                  authcontroller.showpassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onTap: () {
                  authcontroller.onchangepasswordvisibility();
                },
              ),
              obscure: authcontroller.showpassword,
              controller: text_passwordcontroller,
              inputtype: TextInputType.text,
              hinttext: "Password",
              onvalidate: (value) {
                if (value!.isEmpty) return "password must not be empty";
                return null;
              },
            );
          }),
          const SizedBox(
            height: 30,
          ),
          context.watch<AuthController>().isloadingSignIn
              ? const CircularProgressIndicator()
              : defaultButton(
              text: "Sign In",
              height: 50,
              onpress: () async {
                if (_formkey.currentState!.validate()) {
                  String email = text_emailcontroller.text.trim();
                  String password = text_passwordcontroller.text.toString();
                  UserModel? userModel = await context.read<AuthController>().signIn(email, password);
                  if (userModel != null) {
                    text_emailcontroller.clear();
                    text_passwordcontroller.clear();
                    PreferHelper.setUserId(userModel.userId!);
                    PreferHelper.setEmail(email);
                    PreferHelper.setPassword(password);
                    print("sign in successfully > userModel.userId : " + userModel.userId.toString());
                    context.read<MenuController>().buildMenu();
                  }
                }
              }),
        ],
      ),
    );
  }
}
