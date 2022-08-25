import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final String title;
  final VoidCallback clickListener;
  const AuthButton({Key? key,required this.title,required this.clickListener}) : super(key: key);

  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
        color: AppColors.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(20)),
        ),
        onPressed: widget.clickListener,
        child: SizedBox(
          width: size.width / 2,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
