import 'package:flutter/material.dart';
import 'package:flutter_app/models/car.dart';

class Cars extends StatefulWidget {
  final List<Car> cars;
  const Cars({
    super.key,
    required this.cars,
  });

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
