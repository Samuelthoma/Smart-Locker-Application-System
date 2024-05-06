import 'package:eco_apps/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String name = '';
  String dob = '';
  String email = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF0F5),
        title: const Text(
          "Account Information",
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
              "assets/images/mainBackground.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    'Name',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    name.isEmpty ? 'Not Set' : name,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Date of Birth',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    dob.isEmpty ? 'Not Set' : dob,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    email.isEmpty ? 'Not Set' : email,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Phone Number',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    phoneNumber.isEmpty ? 'Not Set' : phoneNumber,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    _showUpdateForm(context);
                  },
                  child: const Text(
                    "Update Data",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showUpdateForm(BuildContext context) async {
    final updatedData = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const _UpdateFormDialog(),
    );

    if (updatedData != null) {
      setState(() {
        name = updatedData['name'] ?? name;
        dob = updatedData['dob'] ?? dob;
        email = updatedData['email'] ?? email;
        phoneNumber = updatedData['phoneNumber'] ?? phoneNumber;
      });
    }
  }
}

class _UpdateFormDialog extends StatefulWidget {
  const _UpdateFormDialog({Key? key}) : super(key: key);

  @override
  _UpdateFormDialogState createState() => _UpdateFormDialogState();
}

class _UpdateFormDialogState extends State<_UpdateFormDialog> {
  late TextEditingController nameController;
  late TextEditingController dobController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dobController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Data'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                    ),
                    enabled: false,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedData = {
              'dob': dobController.text,
              'email': emailController.text,
              'phoneNumber': phoneNumberController.text,
            };
            Navigator.pop(context, updatedData);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
