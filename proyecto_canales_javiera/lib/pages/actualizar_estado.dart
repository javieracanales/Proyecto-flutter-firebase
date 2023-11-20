import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:get/route_manager.dart';
import 'package:proyecto_canales_javiera/services/firestore_service.dart';

// ignore: must_be_immutable
class ActualizarEstado extends StatefulWidget {
  ActualizarEstado({super.key});

  @override
  State<ActualizarEstado> createState() => _ActualizarEstadoState();
}

class _ActualizarEstadoState extends State<ActualizarEstado> {
  final formKeyEstado = GlobalKey<FormState>();

 TextEditingController estadoctrl = TextEditingController();

  @override
  void initState() {
        super.initState();
    firebaseAuth.authStateChanges().listen((event) {
      setState(() {
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Row(
          children: [
        Text("Actualizar estado ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        Text("del evento",style: TextStyle(color: Colors.blue.shade100,fontWeight: FontWeight.bold))
          ],
        ),
        leading: Icon(MdiIcons.partyPopper, color: Colors.blue.shade100,),
        backgroundColor: const Color.fromARGB(255, 49, 28, 53),
      ),
      body: Form(
      key: formKeyEstado,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: StreamBuilder(
          stream: FirestoreService().eventos(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            return Column(
                children: [
                  SizedBox(height: 250,),
                  TextFormField(
                  controller: estadoctrl,
                            decoration: InputDecoration(
                            label: Text('Estado: Finalizado/ Sin finalizar'),
                            border: OutlineInputBorder(),
                 ), ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                    ElevatedButton(
                    child: Text('Actualizar estado del evento'),
                    onPressed: () async{
                      if (formKeyEstado.currentState!.validate()){
                          await FirebaseFirestore.instance.collection('eventos').doc(Get.arguments['id'].toString()).update({
                            'estado': estadoctrl.text,
                          });
                          Navigator.pop(context);
                      }
                    },
                  ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade800,
                            
                          ),
                          child: Text('Cancelar',style: TextStyle(color: Colors.white),),
                          onPressed: () {
                             Navigator.pop(context);
                          },
                        ),
                    ],
                  ),
                ],
            );
          },
          ),
        ),
      ),
    );
  }
}