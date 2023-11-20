import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_canales_javiera/widgets/boton_like.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../services/firestore_service.dart';
import '../widgets/campo_evento.dart';
import '../widgets/campo_imagen.dart';
class PrincipalPublico extends StatefulWidget {

  const PrincipalPublico({super.key});

  @override
  State<PrincipalPublico> createState() => _PrincipalPublicoState();
}

class _PrincipalPublicoState extends State<PrincipalPublico> {
  final formatoFecha = DateFormat('dd/MM/yyyy HH:mm');

@override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
        Text("Javiera",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        Text(" Eventos TM",style: TextStyle(color: Colors.blue.shade100,fontWeight: FontWeight.bold))
          ],
        ),
        leading: Icon(MdiIcons.partyPopper, color: Colors.blue.shade100,),
        backgroundColor: const Color.fromARGB(255, 49, 28, 53),
      ),
      body:  Padding(padding: EdgeInsets.all(8),
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
                            return Container(                      
                                    child: ListTile(
                                    title: Text('${eventos['titulo']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                    subtitle: Container(
                                      child: Row(
                                        children: [
                                          Text(formatoFecha.format(eventos['fecha'].toDate()),style: TextStyle(color: Color.fromARGB(255, 233, 229, 171))),
                                          Icon(MdiIcons.calendar, color: Color.fromARGB(255, 233, 229, 171),),
                                        ],
                                      ),
                                    ),
                                    tileColor: Color.fromARGB(255, 134, 84, 142),
                                    trailing: Column(
                                      children: [
                                        BotonLike(like: true, onTap: (){}),
                                        Text('${eventos['likes']}',textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                      onLongPress: () {
                                        bottomSheet(context, eventos);
                                      },
                                  ),
                            );
                         }),
                    ),
                  ),
                  Container(
                    height:70,
                    width: 250,
                    child: SignInButton(
                        Buttons.google,
                        text: "Iniciar sesión con Google",
                        onPressed: (){
                            FirestoreService().Entrar();
                        },
                    ),
                  )
                ],
              );
          }
        },
      ),
      ),
    );
  }
    void bottomSheet (BuildContext context, eventos){

      showBottomSheet(
        context: context,
        builder: (context){
          return Container(
            height: 600,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 251, 244, 229),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
           padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
                children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
                  child: Text('${eventos['titulo']}', style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 67, 25, 74))),
                ),
                CampoImagen(dato: '${eventos['imagen']}'),
                CampoEvento(dato: '${eventos['descripcion']}'+'.'),
                CampoEvento(dato: 'Lugar del evento: '+'${eventos['lugar']}'),
                CampoEvento(dato: 'Me gusta: '+'${eventos['likes']}'),
                CampoEvento(dato: 'Estado del evento: '+'${eventos['estado']}')
                ],
            ),
          );
        });
  }
}