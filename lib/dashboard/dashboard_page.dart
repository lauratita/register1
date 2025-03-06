import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String username = '';
  String email = '';
  String phone = '';
  String address = '';
  String gender = '';
  String religion = '';
  String birthdate = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      gender = prefs.getString('gender') ?? '';
      religion = prefs.getString('religion') ?? '';
      birthdate = prefs.getString('birthdate') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username: $username", style: const TextStyle(fontSize: 18)),
            Text("Email: $email", style: const TextStyle(fontSize: 18)),
            Text("Phone: $phone", style: const TextStyle(fontSize: 18)),
            Text("Address: $address", style: const TextStyle(fontSize: 18)),
            Text("Gender: $gender", style: const TextStyle(fontSize: 18)),
            Text("Religion: $religion", style: const TextStyle(fontSize: 18)),
            Text("Birthdate: $birthdate", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}