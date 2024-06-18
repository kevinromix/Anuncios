import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/money_format.dart';
import 'package:flutter_app/models/electronic.dart';
import 'package:flutter_app/screens/detalle/change_image.dart';
import 'package:flutter_app/screens/detalle/contactar_vendedor.dart';

class Detalle extends StatelessWidget {
  final Electronic electronic;
  const Detalle({
    super.key,
    required this.electronic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle Anuncio"),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              ChangeImage(
                image1: electronic.image1,
                image2: electronic.image2,
                image3: electronic.image3,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            electronic.model,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                electronic.stars.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "${electronic.reviews} reviews",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            formatCurrency.format(
                                double.parse(electronic.price.replaceAll("\$", ""))),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(electronic.description),
                      ),
                    ],
                  ),
                ),
              ),
              const BtnContactar(),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
