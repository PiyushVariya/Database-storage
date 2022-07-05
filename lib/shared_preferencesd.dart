import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

///instant
SharedPreferences? preferences;

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    preferences?.getString('email');
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'email not vaild' : null,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(left: 40.0),
                        filled: true,
                        hintText: 'Enter email id',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50.0),
                            right: Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) =>
                          value!.isEmpty ? 'password not vaild' : null,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(left: 40.0),
                        filled: true,
                        hintText: 'Enter password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50.0),
                            right: Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {}

                    preferences?.setString('email', emailController.text);
                    preferences?.setString('pass', passwordController.text);
                    print(preferences?.getString('email'));
                    print(preferences?.getString('pass'));
                    emailController.clear();
                    passwordController.clear();
                  },
                  child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
