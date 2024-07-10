import 'package:flutter/material.dart';
import 'package:letstest/screens/sign_up.dart';
import 'package:letstest/services/authentication.dart';
import 'package:letstest/utils/saved_loggedin_user.dart';
import '../widgets/custom_text_form_filed.dart';
import '../widgets/orange_button.dart';
import 'home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final _keyForm = GlobalKey<FormState>();
  late String email, password;
  AuthService authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  signIn() async {
    if (_keyForm.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      try {
        var value = await authService.signEmailPassWord(email, password);
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          SaveUserInfo.saveLoggedInUser(loggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Invalid email or password.';
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                        width: 250,
                      ),
                      const SizedBox(
                        height: 150.0,
                      ),
                      if (errorMessage != null) ...[
                        Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.orangeAccent),
                        ),
                        const SizedBox(height: 20),
                      ],
                      CustomTextFormField(
                        icon: const Icon(Icons.email),
                        hintText: 'Email',
                        obscureText: false,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter your email" : null;
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
                                        builder: (_) => const SignUp()));
                              },
                              child: const Text(
                                'Sign Up',
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
                          signIn();
                        },
                        child: customOrangeButton(context, 'Sign In',
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
