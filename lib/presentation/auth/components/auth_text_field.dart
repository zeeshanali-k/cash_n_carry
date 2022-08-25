import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final IconData prefixIcon;
  final String error;

  const AuthTextField(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.error,
      required this.prefixIcon})
      : super(key: key);

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        fillColor: Colors.deepOrange.shade500,
        hoverColor: Colors.deepOrange.shade500,
        focusColor: Colors.deepOrange.shade500,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width:2.5 , color: Colors.deepOrange.shade200)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width:2.0 ,color: Colors.deepOrange.shade500)),
        // disabledBorder: OutlineInputBorder(
        //     borderRadius: const BorderRadius.all(Radius.circular(35)),
        //     borderSide: BorderSide(color: Colors.deepOrange.shade500)),
        // label: Text("Full Name"),
        prefixIcon: Icon(widget.prefixIcon),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 16,
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return widget.error;
        }
        return null;
      },
    );
  }
}
