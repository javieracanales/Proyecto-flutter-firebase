import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_canales_javiera/pages/principal_admin.dart';
import 'package:proyecto_canales_javiera/pages/principal_publico.dart';
class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? usuario;

    @override
  void initState() {
        super.initState();
    firebaseAuth.authStateChanges().listen((event) {
      setState(() {
        usuario = event;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: usuario != null ? PrincipalAdmin() : PrincipalPublico(),
    );
  }

}