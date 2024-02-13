import 'package:flutter/material.dart';
import 'package:task_number_1/pages/home_page.dart';
import 'package:task_number_1/pages/login_page.dart';
import 'package:task_number_1/services/token_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? token;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    token = await TokenService.getToken();
    setState(() {
      token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return token != null ? const HomePage() : const LoginPage();
  }
}
