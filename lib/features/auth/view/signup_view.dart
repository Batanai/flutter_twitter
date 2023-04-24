
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/constants/constants.dart';
import 'package:twitterclone/features/auth/view/login_view.dart';

import '../../../common/common.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static route() => MaterialPageRoute(
    builder: (context) => const SignUpView() 
  );

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //text1
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 25),
                //text2
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 40),
                //button
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: () {}, 
                    label: 'Done',
                  ),
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: "Already have an account?",
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  children: [
                    TextSpan(
                      text: " Log in",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Pallete.blueColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context, LoginView.route());
                      }
                    )
                  ]
                  )
                )
                //textspan
              ],
            )
          ),
        ),
      ),
    );
  }
}