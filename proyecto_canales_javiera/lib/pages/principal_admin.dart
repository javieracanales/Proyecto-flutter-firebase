import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_canales_javiera/pages/actualizar_estado.dart';
import 'package:proyecto_canales_javiera/pages/agregar_evento.dart';
import 'package:proyecto_canales_javiera/services/firestore_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

class PrincipalAdmin extends StatefulWidget {
  const PrincipalAdmin({super.key});

  @override
  State<PrincipalAdmin> createState() => _PrincipalAdminState();
}

class _PrincipalAdminState extends State<PrincipalAdmin> {
    final formatoFecha = DateFormat('dd/MM/yyyy HH:mm');
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
      appBar: AppBar(
        title: Row(
          children: [
        Text("Javiera Eventos TM ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        Text("Admin",style: TextStyle(color: Colors.blue.shade100,fontWeight: FontWeight.bold))
          ],
        ),
        leading: Icon(MdiIcons.partyPopper, color: Colors.blue.shade100,),
        backgroundColor: const Color.fromARGB(255, 49, 28, 53),
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: StreamBuilder(
        stream: FirestoreService().eventos(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData|| snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
          }else{
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                         separatorBuilder: ((context, index) => Divider()), 
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: ((context, index){
                            var eventos = snapshot.data!.docs[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: StretchMotion(), 
                                children: [
                                  SlidableAction(
                                      backgroundColor: Colors.red,
                                      label: "Eliminar Evento",
                                      icon: MdiIcons.trashCan,
                                    onPressed: (context) {
                                      FirestoreService().borrarEvento(eventos.id);
                                    },),
                                    SlidableAction(
                                      backgroundColor: Colors.green,
                                      label: "Agregar Evento",
                                      icon: MdiIcons.pencil,
                                      onPressed: (context) {
                                        MaterialPageRoute route = MaterialPageRoute(builder: (context) => AgregarEvento());
                                        Navigator.push(context, route);
                                      },
                                    )
                                  ],),
                                  child: ListTile(
                                    tileColor: Color.fromARGB(255, 134, 84, 142),
                                    leading: GestureDetector(
                                      child: Icon(MdiIcons.update,color: Colors.red,),
                                      onTap: () {
                                        Get.to(()=> ActualizarEstado(),
                                        arguments: {
                                          'estado':eventos['estado'],
                                          'id': eventos.id
                                        });
                                      },
                                    ),
                                    trailing: Icon(MdiIcons.arrowLeft, color: Colors.white,),
                                    title: Text('${eventos['titulo']}',style: TextStyle(color: Colors.white),),
                                    subtitle: Text(formatoFecha.format(eventos['fecha'].toDate()),style: TextStyle(color: Colors.blue.shade100)),
                                  ),
                                );
                         }),
                    ),
                  ),
                 SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: const Color.fromARGB(255, 70, 39, 75),
                  ),
                  padding: EdgeInsets.all(20),
                    height:130,
                    width: 330,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text(usuario!.email!, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        SignInButton(
                          text: 'Cerrar sesión con Google',
                          Buttons.google,
                          onPressed: (){
                                FirestoreService().Salir();
                          },
                          )
                      ],
                    )
                  ),
                ],
              );
          }
        },
      ),
      ),
    );
  }
}