import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  DateTime? selectedDate;
  String? gender;
  String? religion;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('address', addressController.text);
    await prefs.setString('gender', gender ?? '');
    await prefs.setString('religion', religion ?? '');
    await prefs.setString('birthdate', selectedDate.toString());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username")),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email")),
            TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password")),
            TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone")),
            TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address")),
            ListTile(
              title: Text(selectedDate == null
                  ? "Select Birthdate"
                  : "Birthdate: ${selectedDate!.toLocal()}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            DropdownButtonFormField(
              value: gender,
              hint: const Text("Select Gender"),
              items: ["Male", "Female"].map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  gender = value as String?;
                });
              },
            ),
            DropdownButtonFormField(
              value: religion,
              hint: const Text("Select Religion"),
              items: ["Islam", "Christianity", "Hinduism", "Buddhism", "Other"]
                  .map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  religion = value as String?;
                });
              },
            ),
            ElevatedButton(onPressed: _register, child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}