
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/common/loading_page.dart';
import 'package:twitterclone/constants/constants.dart';
import 'package:twitterclone/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/features/auth/view/login_view.dart';

import '../../../common/common.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  static route() => MaterialPageRoute(
    builder: (context) => const SignUpView() 
  );

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
      email: emailController.text, 
      password: passwordController.text, 
      context: context
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider); 
    return Scaffold(
      appBar: appBar,
      body: isLoading 
      ? const Loader()
      : Center(
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
                    onTap: onSignUp, 
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