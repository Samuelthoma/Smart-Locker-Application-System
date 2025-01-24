import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eco_apps/screens/main_screen.dart';
import 'package:eco_apps/screens/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    String uri = "http://192.168.215.195/economic/login.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "email": _emailController.text,
        "password": _passwordController.text,
      });

      var response = jsonDecode(res.body);
      if (response["Success"] == "true") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        Fluttertoast.showToast(
          msg: "Invalid Login, Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      // ignore: avoid_print
      print("Error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                top: 197,
                left: 0,
                right: 0,
                child: Center(
                    child: Column(
                        children: [Image.asset('assets/images/logo.png')]))),
            const Positioned(
              top: 101,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "EASY LOCKER",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: 155,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Makes Your Life Easier",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                )),
            Form(
              child: Positioned(
                  top: 313,
                  left: 46,
                  right: 46,
                  child: Container(
                    height: 375,
                    width: 261,
                    decoration: BoxDecoration(
                        color: const Color(0xFFDBF0F5),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.black,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Positioned(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: 'Poppins',
                            ),
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
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              labelText: "Email",
                            ),
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
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              labelText: "Password",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              loginUser();
                            },
                            child: const Text("Login"),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()),
                              );
                            },
                            child: const Text("Sign-up"),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }
}
