import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/dio_service.dart';
import '../services/token_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final username = _usernameController.text;
    final password = _passwordController.text;

    final response = await DioService.post(context, '/first_dart_pro', {
      'username': username,
      'password': password,
    });

    Navigator.pop(context);

    if (response != null) {
      final responseData = json.decode(response);
      final token = responseData['token'];

      await TokenService.setToken(token);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to login. Please try again!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amberAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildCustomText("Log in /", " Sign Up", 18, 28),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  fixedSize: MaterialStateProperty.all(const Size(120, 30)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () => login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomText(
    String logIn,
    String signUp,
    double logInSize,
    double signUpSize,
  ) =>
      Text.rich(
        TextSpan(
          text: logIn,
          children: [
            TextSpan(
              text: signUp,
              style: TextStyle(
                fontSize: logInSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          style: TextStyle(
            fontSize: signUpSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}
