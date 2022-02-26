import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/core/api/notifier/authentication_notifier.dart';
import 'package:thesocialapp/core/api/notifier/utility_notifier.dart';
import 'package:thesocialapp/meta/views/authentication/login_view.dart';

class SignupView extends StatelessWidget {
  static String routeName = "/signup";
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final useremailController = TextEditingController();
    final userpasswordController = TextEditingController();
    var authenticationNotifier = Provider.of<AuthenticationNotifier>(
      context,
      listen: false,
    );
    var utilityNotifier = Provider.of<UtilityNotifier>(
      context,
      listen: false,
    );
    var _userImage = Provider.of<UtilityNotifier>(
      context,
      listen: true,
    ).userImage;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Signup View"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: "Enter your Name",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: useremailController,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: userpasswordController,
                      decoration: const InputDecoration(
                        hintText: "Enter your password",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {
                        utilityNotifier.uploadUserImage(context: context);
                      },
                      color: Colors.red,
                      child: Text(utilityNotifier.userImage!.isEmpty
                          ? "Upload Image"
                          : "Reselect"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _userImage!.isNotEmpty
                        ? Container(
                            height: 100,
                            width: 100,
                            child: Image.network(utilityNotifier.userImage!),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      onPressed: () {
                        authenticationNotifier.signUp(
                          context: context,
                          username: usernameController.text,
                          useremail: useremailController.text,
                          userpassword: userpasswordController.text,
                          userimage: utilityNotifier.userImage!,
                        );
                      },
                      color: Colors.red,
                      child: const Text("Sign Up"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginView.routeName);
                      },
                      child: const Text("Already have an account? Login."),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
