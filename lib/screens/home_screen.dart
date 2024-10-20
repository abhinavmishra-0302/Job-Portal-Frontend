import 'package:flutter/material.dart';
import 'package:job_portal/screens/login_page.dart';
import 'package:job_portal/screens/sign_up.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.center,
            colors: [
              Color.fromRGBO(200, 161, 224, 1), // Bottom color
              Colors.white, // Top color
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Center(
                child: Text('Welcome to the Job Portal', style: TextStyle(fontFamily: 'Oswald Bold', fontSize: 50, color: Colors.purple),),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                child: Text('One stop for finding jobs!', style: TextStyle(fontFamily: 'Oswald Bold', fontSize: 40, color: Color.fromRGBO(200, 161, 224, 1)),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  margin: const EdgeInsets.only(top: 110),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 20, fontFamily: 'Oswald Bold'),),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  margin: const EdgeInsets.only(top: 110, left: 75),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                    },
                    child: const Text('Sign Up', style: TextStyle(fontSize: 20, fontFamily: 'Oswald Bold'),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
