import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF0F5),
        title: const Text(
          "Help Center",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 28,
          ),
        ),
      ),
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
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Welcome to the Help Center!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "If you need assistance, please contact our support team at info@easylocker.com",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Colors.black, // Text color
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "You can also visit our website for FAQs and other resources.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Colors.black, // Text color
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Thank you for using our app!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Colors.black, // Text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
