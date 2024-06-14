import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  // Cars Pagination
  int _carsPagination = 1;
  //
  PageStorageBucket _bucket = PageStorageBucket();
  PageStorageKey _electronicsPagination = PageStorageKey(1);

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
            Cars(
              cars: _cars,
              getCarsPagination: getCarsPagination,
              setCarsPagination: _setCarsPagination,
            ),
            Container(),
            PageStorage(
              bucket: _bucket,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
