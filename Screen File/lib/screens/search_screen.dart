import 'package:flutter/material.dart';
import 'package:eco_apps/screens/notification_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              top: 58,
              right: 19,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/bell.png',
                ),
              )),
          const Positioned(
              top: 50,
              left: 16,
              child: Text(
                "EASY LOCKER",
                style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: 'Poppins',
                ),
              )),
        ],
      ),
    );
  }
}
