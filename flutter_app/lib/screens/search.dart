import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final bool isLoading;
  final Function(String) onTextFieldChanged;
  final Function() onTextFieldClear;
  const SearchTextField({
    super.key,
    required this.isLoading,
    required this.onTextFieldChanged,
    required this.onTextFieldClear,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: !widget.isLoading,
      focusNode: _focusNode,
      controller: _textEditingController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: const Text("Search"),
          prefixIcon: const Icon(Icons.search),
          suffix: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              _textEditingController.clear();
              _focusNode.unfocus();
              widget.onTextFieldClear();
            },
          )),
      onChanged: (value) {
        widget.onTextFieldChanged(value);
      },
    );
  }
}
