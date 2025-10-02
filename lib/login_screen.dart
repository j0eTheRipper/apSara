import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<http.Response> fetchUserInfo(String tpNumber, String password) async {
    var url = '${dotenv.env['BACK_END']!}/auth/login';
    var jsonUser = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'apkey': tpNumber,
        'password': password,
      }),
    );

    return jsonUser;
  }

  @override
  Widget build(BuildContext context) {
    final controllerTPNumber = TextEditingController();
    final controllerPassword = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Login', style: TextStyle(fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controllerTPNumber,
                    decoration: InputDecoration(labelText: 'TP Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your TP number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controllerPassword,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var response = await fetchUserInfo(
                        controllerTPNumber.text,
                        controllerPassword.text,
                      );
                      if (response.statusCode != 200) {
                        final snackBar = SnackBar(
                          content: const Text('Incorrect username Laaah'),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final prefs = SharedPreferencesAsync();
                        await prefs.setString(
                          'tpNumber',
                          controllerTPNumber.text,
                        );
                        await prefs.setString(
                          'password',
                          controllerPassword.text,
                        );
                        final snackBar = SnackBar(
                          content: const Text('Logged in successfully!'),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushNamed(context, '/home');
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
