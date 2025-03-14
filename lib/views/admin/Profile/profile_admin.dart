import 'package:flutter/material.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Admin'),
      ),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}