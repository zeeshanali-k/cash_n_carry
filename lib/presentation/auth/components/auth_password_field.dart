import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final TextEditingController textEditingController;

  const AuthPasswordField({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  _AuthPasswordFieldState createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon:
              Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        hintText: "Password",
        hintStyle: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 16,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide:
                BorderSide(width: 2.5, color: Colors.deepOrange.shade200)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide:
                BorderSide(width: 2.0, color: Colors.deepOrange.shade500)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      obscureText: !isPasswordVisible,
      controller: widget.textEditingController,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter a valid password";
        } else if (val.length < 6) {
          return "Password must be greater than 6";
        }
        return null;
      },
    );
  }
}
