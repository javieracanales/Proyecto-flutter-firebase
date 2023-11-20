import 'package:flutter/material.dart';

class CampoEvento extends StatelessWidget {
  const CampoEvento({
    super.key, required this.dato
    });
      
  final String dato;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
         ),
        margin: EdgeInsets.only(bottom: 3),
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Text(' ' + this.dato,textAlign: TextAlign.center, style: TextStyle(color: const Color.fromARGB(255, 103, 29, 116))),
      ),
    );
  }
}