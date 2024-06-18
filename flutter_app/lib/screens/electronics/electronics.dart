import 'package:flutter_app/models/electronic.dart';
import 'package:flutter_app/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/fetch.dart';

import 'custom_card.dart';

class Electronics extends StatefulWidget {
  final List<Electronic> electronics;
  final int Function() getElectronicsPagination;
  final Function(int) setElectronicsPagination;
  const Electronics({
    super.key,
    required this.electronics,
    required this.getElectronicsPagination,
    required this.setElectronicsPagination,
  });

  @override
  State<Electronics> createState() => _ElectronicsState();
}

class _ElectronicsState extends State<Electronics> {
  static bool _isLoading = true;
  static bool _isLoadingMore = true;
  final List<Electronic> _electronics = [];
  late int _electronicsPagination;
  late bool _maxReached; // Set if all records have been fetched
  final _focusNode = FocusNode();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    _electronics.addAll(widget.electronics);
    _electronicsPagination = widget.getElectronicsPagination();
    if (widget.electronics.isEmpty) _getAutos();
    // Variable to save state when all data has been fetched
    _maxReached = PageStorage.of(context)
            .readState(context, identifier: 'maxReachedElectronics') ??
        false;
    super.initState();
  }

  @override
  void dispose() {
    widget.setElectronicsPagination(_electronicsPagination);
    super.dispose();
  }

  Future<void> _getAutos() async {
    if (_isLoadingMore) {
      await fetch(
        method: "get",
        path: "/api/electronics",
        page: _electronicsPagination.toString(),
      ).then((result) {
        if (!result.hasError) {
          // Verify is not the last data
          if ((result.data as List).length < 5) {
            _maxReached = true;
            PageStorage.of(context).writeState(context, _maxReached,
                identifier: 'maxReachedElectronics');
          }
          for (var electronic in (result.data as List)) {
            Electronic electronicItem = Electronic.fromJson(electronic);
            _electronics.add(electronicItem);
            widget.electronics.add(electronicItem);
          }
          _electronicsPagination++;
        }
        setState(() {
          _isLoading = false;
          _isLoadingMore = false;
        });
      });
    }
  }

  void _onTextFieldChanged(String value) {
    _electronics.clear();
    if (value.isEmpty) {
      _electronics.addAll(widget.electronics);
    } else {
      _electronics.addAll(widget.electronics.where((element) =>
          element.model.toLowerCase().contains(value.toLowerCase())));
    }
    setState(() {});
  }

  void _onTextFieldClear() {
    _electronics.clear();
    _electronics.addAll(widget.electronics);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Widget
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 15, bottom: 10),
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 55),
          child: SearchTextField(
            isLoading: _isLoading,
            onTextFieldChanged: _onTextFieldChanged,
            onTextFieldClear: _onTextFieldClear,
            focusNode: _focusNode,
            textEditingController: _textEditingController,
          ),
        ),
        // List Widget
        Expanded(
          child: _electronics.isNotEmpty
              ? ListView(
                  padding: const EdgeInsets.only(bottom: 10),
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _electronics.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                      itemBuilder: (context, index) {
                        Electronic electronic = _electronics.elementAt(index);
                        return customCard(electronic, context: context);
                      },
                    ),
                    const SizedBox(height: 20),
                    !_maxReached
                        ? !_isLoadingMore
                            ? Align(
                                //"Ver mas" Button widget
                                alignment: Alignment.center,
                                child: TextButton(
                                  style: const ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(
                                      Size(250, 50),
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: Use BLOC to avoid re-render all the widget
                                    setState(() {
                                      _isLoadingMore = true;
                                    });
                                    // Call api for more results
                                    _getAutos();
                                  },
                                  child: const Text("Ver más"),
                                ),
                              )
                            : Container(
                                height: 40,
                                alignment: Alignment.center,
                                child:
                                    const CircularProgressIndicator(), // Loader
                              )
                        : Text(
                            "Mostrando: ${_electronics.length} resultados",
                            textAlign: TextAlign.center,
                          ),
                  ],
                )
              : _isLoading
                  ? const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(), // Main Loader
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const Text("No hay resultados"), // No results
                    ),
        ),
      ],
    );
  }
}
