import 'package:flutter/material.dart';

class TelaComFundo extends StatelessWidget {
  final Widget child;

  const TelaComFundo({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fundo.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}