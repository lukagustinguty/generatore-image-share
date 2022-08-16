import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
  const Carta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
      child: Center(child: Text("Rocio Copa")),
    );
  }
}
