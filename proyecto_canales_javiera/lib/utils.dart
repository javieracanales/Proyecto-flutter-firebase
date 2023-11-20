// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

escogerImagen(ImageSource img) async {
final ImagePicker imagePicker = ImagePicker();
XFile? xFile = await imagePicker.pickImage(source: img);

if(xFile != null){
  return await xFile.readAsBytes();
}

print("No seleccionó ninguna imagen");

}