import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: "Email",
                labelText: "Email",
                prefixIcon: Icon(
                  Icons.alternate_email,
                ),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                  context,
                  emailFocusNode,
                  passwordFocusNode,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordTextEditingController,
                  focusNode: passwordFocusNode,
                  obscureText: _obscurePassword.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        _obscurePassword.value = !value;
                      },
                      child: Icon(
                        value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * .085,
            ),
            RoundButton(
              text: "Sign Up",
              loading: authViewModel.isSignUpLoading,
              onTap: () {
                if (_emailTextEditingController.text.isEmpty &&
                    _passwordTextEditingController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                    "Please Enter Email Address and Password!",
                    context,
                  );
                } else if (_emailTextEditingController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                    "Please Enter Email Address!",
                    context,
                  );
                } else if (_passwordTextEditingController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                    "Please Enter Password!",
                    context,
                  );
                } else if (_passwordTextEditingController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                    "Password should have atleast 6 characters!",
                    context,
                  );
                } else {
                  Map data = {
                    "email": _emailTextEditingController.text,
                    "password": _passwordTextEditingController.text,
                  };
                  authViewModel.signUp(data, context);
                  log("Api Hit!!");
                }
              },
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already registered? "),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
