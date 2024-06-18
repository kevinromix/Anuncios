import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final bool isLoading;
  final Function(String) onTextFieldChanged;
  final Function() onTextFieldClear;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  const SearchTextField({
    super.key,
    required this.isLoading,
    required this.onTextFieldChanged,
    required this.onTextFieldClear,
    required this.focusNode,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: !isLoading,
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: const Text("Search"),
        prefixIcon: const Icon(Icons.search),
        suffix: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            textEditingController.clear();
            focusNode.unfocus();
            onTextFieldClear();
          },
        ),
      ),
      onChanged: (value) {
        onTextFieldChanged(value);
      },
    );
  }
}
