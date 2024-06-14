import 'package:firebase_messaging/firebase_messaging.dart';
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
  // Controller of TabView
  late TabController _tabController;
  // List of cars
  final List<Car> _cars = [];
  // Cars Pagination
  int _carsPagination = 1;
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

  Future<void> setFirebase() async {
    // Instanciate Firabase
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // Request device permissions
    await messaging.requestPermission();
  }

  // GET Cars Pagination
  int getCarsPagination() => _carsPagination;

  // SET Cars Pagination
  void _setCarsPagination(int carsPagination) =>
      _carsPagination = carsPagination;

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
                getCarsPagination: getCarsPagination,
                setCarsPagination: _setCarsPagination,
              ),
            ),
            // Dummy
            Container(
              alignment: Alignment.center,
              child: const Text("No hay resultados."),
            ),
            // Dummy
            Container(
              alignment: Alignment.center,
              child: const Text("No hay resultados."),
            ),
          ],
        ),
      ),
    );
  }
}
