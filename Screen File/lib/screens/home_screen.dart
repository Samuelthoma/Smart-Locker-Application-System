import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eco_apps/screens/notification_screen.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Package {
  final String id;
  final String packageId;
  final String packageCustomerNo;
  final String packageCustomerName;

  Package({
    required this.id,
    required this.packageId,
    required this.packageCustomerNo,
    required this.packageCustomerName,
  });
}

List<Package> packages = [];

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _packageIdController = TextEditingController();
  final TextEditingController _packageCustomerNoController =
      TextEditingController();
  final TextEditingController _packageCustomerNameController =
      TextEditingController();
  final _addPackageKey = GlobalKey<FormState>();

  Future<void> insertData() async {
    String uri = "http://192.168.215.195/economic/insertPackage.php";
    var res = await http.post(Uri.parse(uri), body: {
      "packageId": _packageIdController.text,
      "packageCustomerNo": _packageCustomerNoController.text,
      "packageCustomerName": _packageCustomerNameController.text,
    });

    var response = jsonDecode(res.body);
    if (response["Success"] == "true") {
      // ignore: avoid_print
      print("Data Added");
    } else {
      // ignore: avoid_print
      print("Data can't be added, please try again");
    }
  }

  Future<void> deleteData(String id) async {
    String uri = "http://192.168.215.195/economic/deletePackage.php";
    var res = await http.post(Uri.parse(uri), body: {
      "packageId": id,
    });

    var response = jsonDecode(res.body);
    if (response["Success"] == "true") {
      // ignore: avoid_print
      print("Data Deleted");
    } else {
      // ignore: avoid_print
      print("Data can't be deleted, please try again");
    }
  }

  Future<void> showDeleteConfirmationMessage(String packageId) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Confirmation"),
            content: const Text("Are you sure want to delete this package?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    await deleteData(packageId);
                    setState(() {
                      packages.removeWhere(
                          (package) => package.packageId == packageId);
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }

  Widget _buildQrCode(String packageId) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'QR Code for Package ID : $packageId',
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 22),
              ),
              content: SizedBox(
                width: 150.0,
                height: 150.0,
                child: Align(
                  alignment: Alignment.center,
                  child: QrImageView(
                    data: packageId,
                    version: QrVersions.auto,
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(
        Icons.qr_code,
        size: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDBF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF0F5),
        automaticallyImplyLeading: false,
        title: const Text(
          "Easy Locker",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 35,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/images/bell.png'),
            ),
          ),
        ],
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
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            color: Colors.white.withOpacity(0.65),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Add New Package",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _addPackageKey,
                                  child: Column(children: [
                                    TextFormField(
                                      controller: _packageIdController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your ShippingID";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'Shipping ID'),
                                    ),
                                    TextFormField(
                                      controller: _packageCustomerNoController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your Phone No";
                                        } else if (value.length > 13 ||
                                            value.length < 10) {
                                          return "Phone No Not Valid";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Phone Number'),
                                    ),
                                    TextFormField(
                                      controller:
                                          _packageCustomerNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your Full Name";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'Customer Name'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_addPackageKey.currentState!
                                            .validate()) {
                                          insertData();
                                          Package newPackage = Package(
                                              packageId:
                                                  _packageIdController.text,
                                              packageCustomerNo:
                                                  _packageCustomerNoController
                                                      .text,
                                              packageCustomerName:
                                                  _packageCustomerNameController
                                                      .text,
                                              id: '');
                                          setState(() {
                                            packages.add(newPackage);
                                            _packageIdController.clear();
                                            _packageCustomerNoController
                                                .clear();
                                            _packageCustomerNameController
                                                .clear();
                                          });
                                        }
                                      },
                                      child: const Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (Package package in packages)
                              Positioned(
                                top: packages.indexOf(package) * 70,
                                child: Container(
                                  width: 300,
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ID : ${package.packageId}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Phone No : ${package.packageCustomerNo}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Name : ${package.packageCustomerName}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              showDeleteConfirmationMessage(
                                                  package.packageId);
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15),
                                            )),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        _buildQrCode(package.packageId),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
