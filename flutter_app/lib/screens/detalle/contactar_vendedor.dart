import 'package:flutter/material.dart';
import 'package:flutter_app/screens/detalle/mensajeria/mensajeria.dart';

class BtnContactar extends StatefulWidget {
  const BtnContactar({super.key});

  @override
  State<BtnContactar> createState() => _ContactarState();
}

class _ContactarState extends State<BtnContactar> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const Mensajeria()),
          ),
        );
      },
      child: const Text("Contactar Vendedor"),
    );
  }
}
