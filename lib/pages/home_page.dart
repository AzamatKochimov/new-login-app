import 'package:flutter/material.dart';
import 'package:task_number_1/pages/login_page.dart';
import 'package:task_number_1/services/token_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text('HOME'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text('Settings'),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page'),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await TokenService.removeToken();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx)=> const LoginPage()));
  }
}
