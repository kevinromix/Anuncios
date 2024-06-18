import 'package:flutter/material.dart';
import 'package:flutter_app/models/car.dart';
import 'package:flutter_app/models/electronic.dart';
import 'package:flutter_app/screens/app_bar.dart';
import 'package:flutter_app/screens/cars/cars.dart';
import 'package:flutter_app/screens/electronics/electronics.dart';

import '../helpers/init_firebase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Controller of TabView
  late TabController _tabController;

  // List of cars
  final List<Car> _cars = [];

  // List of electronics
  final List<Electronic> _electronics = [];

  // Cars Pagination
  int _carsPagination = 1;

  // Electronics Pagination
  int _electronicsPagination = 1;

  // Bucket
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    setFirebase();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // GET Cars Pagination
  int _getCarsPagination() => _carsPagination;

  // SET Cars Pagination
  void _setCarsPagination(int carsPagination) =>
      _carsPagination = carsPagination;

  // GET Cars Pagination
  int _getElectronicsPagination() => _electronicsPagination;

  // SET Cars Pagination
  void _setElectronicsPagination(int electronicsPagination) =>
      _electronicsPagination = electronicsPagination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(tabController: _tabController),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Cars Class
            PageStorage(
              bucket: _bucket,
              child: Cars(
                cars: _cars,
                getCarsPagination: _getCarsPagination,
                setCarsPagination: _setCarsPagination,
              ),
            ),
            // Dummy
            Container(
              alignment: Alignment.center,
              child: const Text("No hay resultados."),
            ),
            // Electronics class
            PageStorage(
              bucket: _bucket,
              child: Electronics(
                electronics: _electronics,
                getElectronicsPagination: _getElectronicsPagination,
                setElectronicsPagination: _setElectronicsPagination,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
