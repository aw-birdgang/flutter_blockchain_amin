import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuController.dart';
import '../../../controllers/auth_controller.dart';
import '../../../shared/components/default_button.dart';
import '../../../shared/components/default_text_form.dart';

class LoginForm extends StatelessWidget {
  var text_emailcontroller = TextEditingController();
  var text_passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login Screen",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
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
          SizedBox(
            height: 30,
          ),
          context.watch<AuthController>().isloadingSignIn
              ? const CircularProgressIndicator()
              : defaultButton(
              text: "Sign In",
              height: 50,
              onpress: () {
                if (_formkey.currentState!.validate()) {
                  context.read<AuthController>()
                    ..signIn(text_emailcontroller.text.trim(),
                        text_passwordcontroller.text.toString())
                        .then((value) {
                      if (value != null) {
                        text_emailcontroller.clear();
                        text_passwordcontroller.clear();
                        print("sign in successfully");
                        context.read<MenuController>()..buildMenu();
                      } else {}
                    });
                }
              }),
        ],
      ),
    );
  }
}
