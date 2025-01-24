import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LockerScreen extends StatefulWidget {
  const LockerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LockerScreenState createState() => _LockerScreenState();
}

class Locker {
  final String id;
  final String lockerName;

  Locker({
    required this.id,
    required this.lockerName,
  });
}

class _LockerScreenState extends State<LockerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Locker> lockerResults = [];
  bool showNoLockersFound = false;
  bool isLoading = false;

  Future<void> searchLockers(String searchTerm) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://192.168.215.195/economic/locker.php?search=$searchTerm"));

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        setState(() {
          lockerResults = results
              .map<Locker>((result) => Locker(
                    id: result['id'],
                    lockerName: result['locker_name'],
                  ))
              .toList();
          showNoLockersFound = lockerResults.isEmpty;
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      setState(() {
        showNoLockersFound = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> fetchAddress(String lockerId) async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.215.195/economic/lockerAddress.php?id=$lockerId"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['address'];
      } else {
        throw Exception('Failed to fetch address');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return 'Failed to fetch address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDBF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBF0F5),
        title: const Text(
          'Locker Search',
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    searchLockers(value);
                  } else {
                    setState(() {
                      showNoLockersFound = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Search for lockers',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : showNoLockersFound
                        ? const Center(child: Text('No lockers found'))
                        : ListView.builder(
                            itemCount: lockerResults.length,
                            itemBuilder: (context, index) {
                              final locker = lockerResults[index];
                              return ListTile(
                                title: Text(
                                  locker.lockerName,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 18),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () async {
                                    final address =
                                        await fetchAddress(locker.id);
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Locker Address'),
                                        content: Text(
                                          address,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
