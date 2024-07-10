import 'package:flutter/material.dart';
import 'package:letstest/screens/sign_in.dart';
import 'package:letstest/services/authentication.dart';
import 'package:letstest/utils/saved_loggedin_user.dart';
import 'package:letstest/widgets/orange_button.dart';
import '../widgets/custom_text_form_filed.dart';
import 'home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _keyForm = GlobalKey<FormState>();
  late String name, email, password;
  AuthService authService = new AuthService();
  bool isLoading = false;

  signUp() async {
    if (_keyForm.currentState!.validate()) {
      setState(() {
        isLoading = true;
        ;
      });
      await authService.signUpWithEmailPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          SaveUserInfo.saveLoggedInUser(loggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Container(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 85,
                      ),
                      Image.asset(
                        'asset/images/logo.png',
                        height: 250,
                        width: 2500,
                      ),
                      const SizedBox(
                        height: 150.0,
                      ),
                      CustomTextFormField(
                        icon: const Icon(Icons.email),
                        hintText: 'Enter your name',
                        obscureText: false,
                        onChanged: (value) {
                          name = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter your name" : null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        icon: const Icon(Icons.email),
                        hintText: 'Email',
                        obscureText: false,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter your mail" : null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        icon: const Icon(Icons.password_rounded),
                        hintText: 'Password',
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter your password" : null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('Already have an account?'),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SignIn()));
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.orangeAccent),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: customOrangeButton(context, 'Sign Up',
                            fullWidth: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
