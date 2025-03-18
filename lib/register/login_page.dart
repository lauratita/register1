import 'package:register1/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';

// perubahan state
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // deklarasi
  final TextEditingController usernameController =
      TextEditingController(); //mengambil input dari text field
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

// otentikasi
  Future<void> _login() async {
    // mengambil data dari shared preferences atau data yang tersimpan secara lokal saat regis
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredUsername = prefs.getString('username');
    String? registeredPassword = prefs.getString('password');

// perbandingan
    if (usernameController.text == registeredUsername &&
        passwordController.text == registeredPassword) {
      Navigator.pushReplacement(
        //navigator push untuk pindah halaman berikutnya dan menghapus halaman sebelumnya
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid username or password';
      });
    }
  }

// halaman UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push( //pindah halaman 
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
