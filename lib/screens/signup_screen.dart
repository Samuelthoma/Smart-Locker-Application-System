import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _accountCreated = false;
  bool _duplicateEmail = false;

  Future<void> registerUser() async {
    String uri = "http://192.168.215.195/economic/user.php";
    var res = await http.post(Uri.parse(uri), body: {
      "email": _emailController.text,
      "password": _passwordController.text,
    });

    var response = jsonDecode(res.body);
    if (response["Success"] == "true") {
      setState(() {
        _accountCreated = true;
      });
    } else if (response["duplicate"] == "true") {
      setState(() {
        _duplicateEmail = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBF0F5),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/mainBackground.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 120,
            left: 155,
            child: Image.asset('assets/images/logo.png'),
          ),
          Positioned(
            top: 250,
            left: 46,
            right: 46,
            child: Container(
              width: 261,
              decoration: BoxDecoration(
                color: const Color(0xFFDBF0F5),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 3.0,
                  color: Colors.black,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    child: _duplicateEmail
                        ? _buildDuplicateEmailContent(context)
                        : _accountCreated
                            ? _buildSuccessContent(context)
                            : Form(
                                key: _formSignInKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Enter Your Email";
                                          } else if (!EmailValidator.validate(
                                              value)) {
                                            return "Please Enter A Valid Email";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          labelText: "Email",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Enter The Password";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          labelText: "Password",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Confirm Your Password";
                                          } else if (value !=
                                              _passwordController.text) {
                                            return "Passwords do not match";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                          ),
                                          labelText: "Confirm Password",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      SizedBox(
                                        width: 270,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formSignInKey.currentState!
                                                .validate()) {
                                              await registerUser();
                                            }
                                          },
                                          child: const Text("Submit"),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSuccessContent(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: 10,
      ),
      const Icon(
        Icons.check_circle_outline_outlined,
        size: 80,
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Account Created Succesfully",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Back To Home"),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}

Widget _buildDuplicateEmailContent(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: 10,
      ),
      const Icon(
        Icons.error_outline,
        size: 80,
        color: Colors.red,
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Email already exists",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          color: Colors.red,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "Back to home",
          style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
