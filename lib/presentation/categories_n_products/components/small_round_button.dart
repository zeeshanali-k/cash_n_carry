import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallRoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const SmallRoundButton(
      {Key? key, required this.text, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.backgroundColor),
        child: Text(
          text,
          style: TextStyles.textSmallWhiteNormal,
        ),
      ),
    );
  }
}
