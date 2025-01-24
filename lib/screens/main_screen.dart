import 'package:eco_apps/screens/home_screen.dart';
import 'package:eco_apps/screens/locker_screen.dart';
import 'package:eco_apps/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List screens = const [
    HomeScreen(),
    LockerScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDBF0F5),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavigationItem(
                    title: "Home",
                    icon: "assets/images/home.png",
                    activeIcon: "assets/images/homeActive.png",
                    isActive: currentTab == 0,
                    onTap: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                  ),
                  BottomNavigationItem(
                    title: "Locker",
                    icon: "assets/images/addbox.png",
                    activeIcon: "assets/images/addboxActive.png",
                    isActive: currentTab == 1,
                    onTap: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                  ),
                  BottomNavigationItem(
                    title: "Profile",
                    icon: "assets/images/person.png",
                    activeIcon: "assets/images/personActive.png",
                    isActive: currentTab == 2,
                    onTap: () {
                      setState(() {
                        currentTab = 2;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isActive;
  final String activeIcon;
  final Function() onTap;
  const BottomNavigationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.activeIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Image.asset(
                isActive ? activeIcon : icon,
                width: 30,
                height: 30,
              ),
              Text(
                title,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
            ],
          )),
    );
  }
}
