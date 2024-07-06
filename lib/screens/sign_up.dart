import 'package:flutter/material.dart';
import 'package:letstest/screens/sign_in.dart';

import '../widgets/custom_text_form_filed.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _keyForm = GlobalKey<FormState>();
  late String name,email, password;
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
                  hintText: 'Enter your name',
                  obscureText: false,
                  onChanged: (value){
                    name = value;
                  },
                  validator: (value){ return value!.isEmpty ? "Enter your name" : null;},
                ),
                const SizedBox(
                  height: 15,
                ),
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SignIn()));
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
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 18.0),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
