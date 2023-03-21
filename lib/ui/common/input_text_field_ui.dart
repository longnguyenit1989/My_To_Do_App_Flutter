import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    this.hintText,
    this.obscureText,
    this.autofocus,
    this.onChanged,
    this.errorText,
    this.textFieldController
  }) : super(key: key);

  final String? hintText;
  final bool? obscureText;
  final bool? autofocus;
  final void Function(String value)? onChanged;
  final String? errorText;
  final TextEditingController? textFieldController;

  @override
  Widget build(BuildContext context) {

    return TextField(
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      autofocus: autofocus ?? false,
      controller: textFieldController,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          errorText: errorText),
    );
  }
}
