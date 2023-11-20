import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_canales_javiera/services/firestore_service.dart';

import '../utils.dart';


class AgregarEvento extends StatefulWidget {
  const AgregarEvento({super.key});

  @override
  State<AgregarEvento> createState() => _AgregarEventoState();
}

class _AgregarEventoState extends State<AgregarEvento> {
  TextEditingController nombrectrl = TextEditingController();
  TextEditingController fechactrl = TextEditingController();
  TextEditingController lugarctrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController tipoCtrl = TextEditingController();
  TextEditingController imagenCtrl = TextEditingController();
  TextEditingController estadoctrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
        Text("Agregar ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        Text("nuevo evento",style: TextStyle(color: Colors.blue.shade100,fontWeight: FontWeight.bold))
          ],
        ),
        leading: Icon(MdiIcons.partyPopper, color: Colors.blue.shade100,),
        backgroundColor: const Color.fromARGB(255, 49, 28, 53),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Expanded(
            child: ListView(
              children: [
                SizedBox(height: 24,),
                TextFormField(
                  controller: nombrectrl,
                  decoration: InputDecoration(
                    label: Text('Nombre del evento'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (nombre) {
                    if (nombre!.isEmpty) {
                      return 'Indique el nombre del evento a publicar...';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24,),
                TextFormField(
                  controller: lugarctrl,
                  decoration: InputDecoration(
                    label: Text('Lugar donde se realizará el evento'),
                    border: OutlineInputBorder(),                  
                  ),
                  validator: (lugar) {
                    if (lugar!.isEmpty) {
                      return 'Indique el lugar donde ser realizará el evento a publicar...';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24,),
                TextFormField(
                  controller: descripcionCtrl,
                  decoration: InputDecoration(
                    label: Text('Descripción del evento'),
                    border: OutlineInputBorder(),                     
                  ),
                  validator: (nombre) {
                    if (nombre!.isEmpty) {
                      return 'Escriba una descripción para el evento a publicar...';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24,),
                TextFormField(
                  controller: tipoCtrl,
                  decoration: InputDecoration(
                    label: Text('Tipo: Concierto/Fiesta/Evento deportivo/Beneficiencia'),
                    border: OutlineInputBorder(),   
                  ),
                  validator: (nombre) {
                    if (nombre!.isEmpty) {
                      return 'Escriba una descripción para el evento a publicar...';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: estadoctrl,
                            decoration: InputDecoration(
                            label: Text('Estado: Finalizado/ Sin finalizar'),
                            border: OutlineInputBorder(),
                 ), ),
                SizedBox(height: 10,),
                ElevatedButton( 
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('        Escoger imagen para el evento '),
                      Icon(Icons.add_a_photo)
                    ],
                  ),
                  onPressed: seleccionarImagen,
                  ),
                   SizedBox(height: 10,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green
                          ),
                          child: Text("Subir evento",style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            if (formKey.currentState!.validate()){
                                    String nom = nombrectrl.text;
                                    DateTime fecha = DateTime.now();
                                    String lugar = lugarctrl.text;
                                    String desc = descripcionCtrl.text;
                                    String tip = tipoCtrl.text;
                                    String est = estadoctrl.text;
                                    int like = 0;
                              FirestoreService().agregarEvento(
                                nom, 
                                fecha, 
                                lugar, 
                                desc, 
                                tip, 
                                like, 
                                img!,
                                est);
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
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
   Uint8List? img;
  void seleccionarImagen ()async {
   try{
     Uint8List imagen = await escogerImagen(ImageSource.gallery);
    setState(() {
      img = imagen;
    });
    }catch(error){
       error;
    }
  }
}