import 'package:eco_apps/screens/settingScreen/account_screen.dart';
import 'package:eco_apps/screens/settingScreen/address_screen.dart';
import 'package:eco_apps/screens/settingScreen/help_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF0F5),
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 35),
        ),
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/mainBackground.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Image.asset(
                  "assets/images/person.png",
                  width: 40,
                ),
                title: const Text(
                  'Account Information',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 23,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountScreen(),
                      ));
                },
              ),
              const Divider(),
              ListTile(
                leading: Image.asset(
                  "assets/images/home.png",
                  width: 40,
                ),
                title: const Text(
                  'Address',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 23),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressScreen(),
                      ));
                },
              ),
              const Divider(),
              ListTile(
                leading: Image.asset(
                  "assets/images/help.png",
                  width: 40,
                ),
                title: const Text(
                  'Help Center',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 23),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpCenterScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
