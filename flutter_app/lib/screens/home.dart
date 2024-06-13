import 'package:flutter/material.dart';
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
  static const List<Car> _cars = [];

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(tabController: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Cars(cars: _cars),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
