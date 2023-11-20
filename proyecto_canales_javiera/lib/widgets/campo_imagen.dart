import 'package:flutter/material.dart';

class CampoImagen extends StatelessWidget {
  const CampoImagen({
    super.key, required this.dato
    });
      
  final String dato;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: const Color.fromARGB(255, 67, 25, 74)
      ),
      margin: EdgeInsets.only(bottom: 3),
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Image(image: NetworkImage(this.dato))
    );
  }
}