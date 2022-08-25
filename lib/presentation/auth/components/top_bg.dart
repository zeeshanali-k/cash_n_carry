import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TopBg extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.backgroundColor
      ..style = PaintingStyle.fill;
    // final circlePath = Path()
    //   ..moveTo(20, size.height*0.3)
    //   ..quadraticBezierTo(0, size.height*0.3, size.width, size.height*0.3)
    //   ..close();
    canvas.drawCircle(Offset(size.width/2,-(size.height*0.8)), size.width, paint);

    // canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
