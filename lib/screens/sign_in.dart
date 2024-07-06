import 'package:flutter/material.dart';
import 'package:letstest/screens/sign_up.dart';

import '../widgets/custom_text_form_filed.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                Image.asset('asset/images/logo.png',height: 250,width: 2500,),
                const SizedBox(height: 150.0,),
                CustomTextFormField(
                  icon: const Icon(Icons.email),
                  hintText: 'Email',
                  obscureText: false,
                  onChanged: (value){
                    email = value;
                  },
                  validator: (value){ return value!.isEmpty ? "Enter your mail" : null;},
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                 icon: const Icon(Icons.password_rounded),
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (value){
                   password = value;
                  },
                  validator: (value){ return value!.isEmpty ? "Enter your password" : null;},
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Already have an account?'),
                    const SizedBox(width: 5,),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SignUp()));

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
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('SignIn',style: TextStyle(color: Colors.white,fontSize: 18.0),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
