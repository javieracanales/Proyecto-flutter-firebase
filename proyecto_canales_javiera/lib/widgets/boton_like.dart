import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
// ignore: must_be_immutable
class BotonLike extends StatelessWidget {

BotonLike({super.key, required this.like, required this.onTap});

final bool like;
void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(
          like ? MdiIcons.heart: MdiIcons.heart,
          color: like ? Colors.red: Color.fromARGB(255, 43, 43, 43),
        ),
    );
  }
}