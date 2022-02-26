import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/core/api/notifier/authentication_notifier.dart';
import 'package:thesocialapp/meta/views/authentication/signup_view.dart';

class LoginView extends StatelessWidget {
  static String routeName = "/login";
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    var authenticationNotifier = Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login View"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    authenticationNotifier.login(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  color: Colors.red,
                  child: const Text("Login"),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupView.routeName);
                  },
                  child: const Text("New? Signup."),
                )
              ],
            ),
          ),
        ));
  }
}
