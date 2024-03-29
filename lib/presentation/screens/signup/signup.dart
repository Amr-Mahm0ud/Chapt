import 'package:chapt/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.signin);
            },
            child: const Text('singin')),
      ),
    );
  }
}
