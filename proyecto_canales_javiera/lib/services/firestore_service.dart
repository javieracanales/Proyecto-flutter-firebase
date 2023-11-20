import 'dart:core';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class FirestoreService {
  //obtener lista
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  Future<String> subirImagen(String nombre,Uint8List imagen)async{
      Reference ref = storage.ref().child(nombre);
      UploadTask uploadTask = ref.putData(imagen);
      TaskSnapshot snapshot = await uploadTask;
     String descargarURL = await snapshot.ref.getDownloadURL();
     return descargarURL;
  }

  //insertar
 Future<String> agregarEvento(String titulo,DateTime fecha, String lugar, String descripcion,String tipo,int likes, Uint8List imagen, String estado)async{

    String response = "Evento agregado...";
    String urlImagen= await subirImagen('imagen', imagen);
    await firebaseFirestore.collection('eventos').add({
      'titulo': titulo,
      'fecha': DateTime.now(),
      'lugar': lugar,
      'descripcion': descripcion,
      'tipo': tipo,
      'likes': 0,
      'imagen': urlImagen,
      'estado': estado
    });
    return response;
 }

  //actualizar
  Future<String> actualizarEstado(String estado, String docId)async{
      String response = "Estado actualizado...";
      await firebaseFirestore.collection('eventos').doc(docId).update({
        'estado': estado
      });
      return response;
  }

  //borrar
  Future<void> borrarEvento(String docId) async {
    return FirebaseFirestore.instance.collection('eventos').doc(docId).delete();
  }
  //login entrar
     Future<void>Entrar()async{
          try{
            GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
            firebaseAuth.signInWithProvider(googleAuthProvider);
          }
          catch(error){
            print(error);
          }
}
  //login salir
   Future<void>Salir() => firebaseAuth.signOut();
   

}
