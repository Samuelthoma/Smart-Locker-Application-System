import 'package:eco_apps/screens/main_screen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          const Positioned(
              top: 50,
              left: 16,
              child: Text(
                "Notification",
                style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: 'Poppins',
                ),
              )),
          const Center(
            child: Text(
              "There's No Notiffication Yet",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25,
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 0,
            right: 0,
            child: Center(
              child: Column(children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                    );
                  },
                  child: const Text(
                    "Back To Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
