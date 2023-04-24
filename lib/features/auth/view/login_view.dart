import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/common/common.dart';
import 'package:twitterclone/features/auth/view/signup_view.dart';
import 'package:twitterclone/features/auth/widgets/auth_field.dart';
import 'package:twitterclone/theme/theme.dart';

import '../../../constants/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static route() => MaterialPageRoute(
    builder: (context) => const LoginView() 
  );

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    text: "Don't have an account?",
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  children: [
                    TextSpan(
                      text: " Sign up",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Pallete.blueColor
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context, SignUpView.route());
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