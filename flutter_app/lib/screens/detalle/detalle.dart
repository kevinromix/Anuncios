import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/money_format.dart';
import 'package:flutter_app/models/car.dart';
import 'package:flutter_app/screens/detalle/change_image.dart';
import 'package:flutter_app/screens/detalle/contactar_vendedor.dart';

class Detalle extends StatelessWidget {
  final Car car;
  const Detalle({
    super.key,
    required this.car,
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
                image1: car.image1,
                image2: car.image2,
                image3: car.image3,
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
                            car.model,
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
                                car.stars.toString(),
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
                                "${car.reviews} reviews",
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
                                double.parse(car.price.replaceAll("\$", ""))),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(car.description),
                      ),
                    ],
                  ),
                ),
              ),
              const Contactar(),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
