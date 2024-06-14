import 'package:flutter/material.dart';
import 'package:flutter_app/screens/detalle/mensajeria/mensajeria.dart';

class Contactar extends StatefulWidget {
  const Contactar({super.key});

  @override
  State<Contactar> createState() => _ContactarState();
}

class _ContactarState extends State<Contactar> {
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
