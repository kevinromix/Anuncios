import 'package:flutter/material.dart';
import 'package:flutter_app/api/fetch.dart';

class Mensajeria extends StatefulWidget {
  const Mensajeria({super.key});

  @override
  State<Mensajeria> createState() => _MensajeriaState();
}

class _MensajeriaState extends State<Mensajeria> {
  final _formKey = GlobalKey<FormState>();
  bool _canValidate = false;
  bool _isSending = false;
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _mensajeController = TextEditingController();

  // Mail Validation
  bool isValidEmail(value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  //Method to call api of sendMessage
  Future<void> _sendMessage({
    required String nombre,
    required String correo,
    required String mensaje,
  }) async {
    await fetch(
        // hostIp:
        // "192.168.1.22",
        //Use PC IP Network, just in case localhost does not work in mobile test
        method: "post",
        path: "/api/mensaje",
        body: {
          "Nombre": nombre,
          "Correo": correo,
          "Mensaje": mensaje,
        }).then((result) {
      if (!result.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mensaje enviado"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Custom profile
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 70,
                    ),
                    // Custom profile name
                    Text(
                      "Jonth Smith",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 30),
                    // PHONE
                    const Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10),
                        Text("Call"),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Card(
                      child: ListTile(
                        title: Text("Mobile"),
                        subtitle: Text("+91 98765 43210"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(width: 10),
                        Text("Mail"),
                      ],
                    ),
                    // Form to send the message
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nombreController,
                            enabled: !_isSending,
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Nombre",
                            ),
                            autovalidateMode: _canValidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa el campo";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _correoController,
                            enabled: !_isSending,
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Correo Contacto",
                            ),
                            autovalidateMode: _canValidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Completa el campo";
                              } else if (!isValidEmail(value)) {
                                return "Ingrese un email valido";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Texto Correo",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 180,
                            child: TextFormField(
                              controller: _mensajeController,
                              enabled: !_isSending,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              autovalidateMode: _canValidate
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Completa el campo";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Button with action to send message
                          ElevatedButton(
                            onPressed: !_isSending
                                ? () async {
                                    if (!_canValidate) {
                                      setState(() {
                                        _canValidate = true;
                                      });
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isSending = true;
                                      });
                                      await _sendMessage(
                                        nombre: _nombreController.text,
                                        correo: _correoController.text,
                                        mensaje: _mensajeController.text,
                                      );
                                    }
                                  }
                                : null,
                            child: const Text("Enviar Correo"),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
