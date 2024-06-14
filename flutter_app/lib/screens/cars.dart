import 'package:flutter_app/screens/search.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/fetch.dart';
import 'package:flutter_app/models/car.dart';

class Cars extends StatefulWidget {
  final List<Car> cars;
  final int Function() getCarsPagination;
  final Function(int) setCarsPagination;
  const Cars({
    super.key,
    required this.cars,
    required this.getCarsPagination,
    required this.setCarsPagination,
  });

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  static bool _isLoading = true;
  static bool _isLoadingMore = true;
  final List<Car> _cars = [];
  late int _carsPagination;
  late bool _maxReached; // Set if all records have been fetched
  // Money format
  final NumberFormat formatCurrency = NumberFormat.simpleCurrency(
    locale: "es_MX",
    name: "\$",
    decimalDigits: 2,
  );

  @override
  void initState() {
    _cars.addAll(widget.cars);
    _carsPagination = widget.getCarsPagination();
    if (widget.cars.isEmpty) _getAutos();
    _maxReached =
        PageStorage.of(context).readState(context, identifier: 'maxReached') ??
            false;
    super.initState();
  }

  @override
  void dispose() {
    widget.setCarsPagination(_carsPagination);
    super.dispose();
  }

  Future<void> _getAutos() async {
    if (_isLoadingMore) {
      await fetch(
        method: "get",
        path: "/api/autos",
        page: _carsPagination.toString(),
      ).then((result) {
        if ((result.data as List).length < 5) {
          _maxReached = true;
          PageStorage.of(context)
              .writeState(context, _maxReached, identifier: 'maxReached');
        }
        for (var car in (result.data as List)) {
          Car carItem = Car.fromJson(car);
          _cars.add(carItem);
          widget.cars.add(carItem);
        }
        setState(() {
          _carsPagination++;
          _isLoading = false;
          _isLoadingMore = false;
        });
      });
    }
  }

  Card customCard(car) {
    return Card(
      elevation: 3,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: 120),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          leading: Image.asset(
            'assets/${car.image1}.jpg',
            fit: BoxFit.cover,
            width: 100,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  car.model,
                  softWrap: false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                formatCurrency
                    .format(double.parse(car.price.replaceAll("\$", ""))),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          subtitle: Text(
            car.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  void _onTextFieldChanged(value) {
    _cars.clear();
    if (value.isEmpty) {
      _cars.addAll(widget.cars);
    } else {
      _cars.addAll(widget.cars.where((element) =>
          element.model.toLowerCase().contains(value.toLowerCase())));
    }
    setState(() {});
  }

  void _onTextFieldClear() {
    _cars.clear();
    _cars.addAll(widget.cars);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 15, bottom: 10),
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 55),
          child: SearchTextField(
            isLoading: _isLoading,
            onTextFieldChanged: _onTextFieldChanged,
            onTextFieldClear: _onTextFieldClear,
          ),
        ),
        Expanded(
          child: _cars.isNotEmpty
              ? ListView(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _cars.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                      itemBuilder: (context, index) {
                        Car car = _cars.elementAt(index);
                        return customCard(car);
                      },
                    ),
                    const SizedBox(height: 20),
                    !_maxReached
                        ? !_isLoadingMore
                            ? Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  style: const ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll(
                                      Size(250, 50),
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: Use BLOC to avoid re-render all the widget
                                    setState(() {
                                      _isLoadingMore = true;
                                    });

                                    _getAutos();
                                  },
                                  child: const Text("Ver más"),
                                ),
                              )
                            : Container(
                                height: 40,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              )
                        : Text(
                            "Mostrando: ${_cars.length} resultados",
                            textAlign: TextAlign.center,
                          ),
                  ],
                )
              : _isLoading
                  ? const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const Text("No hay resultados"),
                    ),
        ),
      ],
    );
  }
}
