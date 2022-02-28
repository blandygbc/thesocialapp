import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesocialapp/app_constants.dart';
import 'package:thesocialapp/core/notifier/authentication_notifier.dart';
import 'package:thesocialapp/core/notifier/utility_notifier.dart';
import 'package:thesocialapp/meta/views/authentication/login_view.dart';

class SignupView extends StatefulWidget {
  static String routeName = "/signup";
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  @override
  void initState() {
    usernameController = TextEditingController();
    useremailController = TextEditingController();
    userpasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier authenticationNotifier(bool renderUi) =>
        Provider.of<AuthenticationNotifier>(
          context,
          listen: renderUi,
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
                      onChanged: (value) {
                        authenticationNotifier(false)
                            .checkPasswordStrength(candidatePassword: value);
                      },
                      controller: userpasswordController,
                      decoration: const InputDecoration(
                          hintText: "Enter your password"),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(authenticationNotifier(true).passwordEmoji),
                      if (authenticationNotifier(true).passwordLevel ==
                          kPasswordWeek)
                        AnimatedContainer(
                            width: 100,
                            height: 10,
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      if (authenticationNotifier(true).passwordLevel ==
                          kPasswordMedium)
                        AnimatedContainer(
                            width: 220,
                            height: 10,
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(15),
                            )),
                      if (authenticationNotifier(true).passwordLevel ==
                          kPasswordStrong)
                        AnimatedContainer(
                            width: 330,
                            height: 10,
                            curve: Curves.easeInOutQuad,
                            duration: const Duration(seconds: 2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                            )),
                    ]),
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
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(utilityNotifier.userImage!),
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      onPressed: () {
                        authenticationNotifier(false).signUp(
                          context: context,
                          username: usernameController.text.trim(),
                          useremail:
                              useremailController.text.toLowerCase().trim(),
                          userpassword: userpasswordController.text,
                          userimage: utilityNotifier.userImage ?? '',
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
