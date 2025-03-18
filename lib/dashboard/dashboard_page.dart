import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; //mengambil data yang sudah tersimpan saat register

// data pengguna akan diambil dari shared preferences dan perbarui UI
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

// deklarasi
class _DashboardPageState extends State<DashboardPage> {
  String username = ''; //menyimpan data yang diambil dari shared preferences
  String email = '';
  String phone = '';
  String address = '';
  String gender = '';
  String religion = '';
  String birthdate = '';

  @override
  // mengambil data dari shared preferences
  void initState() {
    super.initState();
    _loadUserData(); //mengambil data
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); //mengambil data yang sudah disimpan
    setState(() {
      username = prefs.getString('username') ??
          ''; //kalau data kosong/tidak ada, menggunakan string kosong
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      gender = prefs.getString('gender') ?? '';
      religion = prefs.getString('religion') ?? '';
      birthdate = prefs.getString('birthdate') ?? '';
    });
  }

// UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username: $username",
                style: const TextStyle(
                    fontSize:
                        18)), //$username akan menampilkan isi dari variabel username ($ untuk menggantikan variabel dalam string)
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
