import 'package:flutter/material.dart';
import 'package:flutter_app/api/fetch.dart';
import 'package:flutter_app/models/car.dart';
import 'package:flutter_app/screens/app_bar.dart';
import 'package:flutter_app/screens/cars.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Controlador del TabView
  late TabController _tabController;
  // Lista de autos
  final List<Car> _cars = [];

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _getAutos();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getAutos() async {
    await fetch(method: "get", path: "/autos").then((result) {
      print(result.hasError);
      print(result.message);
      (result.data).forEach((car) => _cars.add(Car.fromJson(car)));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(tabController: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: [
          Cars(cars: _cars),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
