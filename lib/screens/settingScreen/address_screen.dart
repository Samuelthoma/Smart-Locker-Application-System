import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String province = '';
  String city = '';
  String postCode = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF0F5),
        title: const Text(
          "Address Information",
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
                    'Province',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    province.isEmpty ? 'Not Set' : province,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'City',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    city.isEmpty ? 'Not Set' : city,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Post Code',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    postCode.isEmpty ? 'Not Set' : postCode,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Address',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                  subtitle: Text(
                    address.isEmpty ? 'Not Set' : address,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    _showUpdateForm(context);
                  },
                  child: const Text(
                    "Update Data",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
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
        province = updatedData['province'] ?? province;
        city = updatedData['city'] ?? city;
        postCode = updatedData['postCode'] ?? postCode;
        address = updatedData['address'] ?? address;
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
  late TextEditingController provinceController;
  late TextEditingController cityController;
  late TextEditingController postCodeController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    provinceController = TextEditingController();
    cityController = TextEditingController();
    postCodeController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    provinceController.dispose();
    cityController.dispose();
    postCodeController.dispose();
    addressController.dispose();
    super.dispose();
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
              controller: provinceController,
              decoration: const InputDecoration(
                labelText: 'Province',
              ),
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
              ),
            ),
            TextField(
              controller: postCodeController,
              decoration: const InputDecoration(
                labelText: 'Post Code',
              ),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
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
              'province': provinceController.text,
              'city': cityController.text,
              'postCode': postCodeController.text,
              'address': addressController.text,
            };
            Navigator.pop(context, updatedData);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
