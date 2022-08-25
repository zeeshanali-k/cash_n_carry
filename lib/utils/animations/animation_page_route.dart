import 'package:flutter/material.dart';

class AnimationPageRoute extends PageRouteBuilder {
  final Widget child;

  AnimationPageRoute({required this.child, required RouteSettings settings})
      : super(
            pageBuilder: (c, a, ac) => child,
            transitionDuration: const Duration(milliseconds: 250),
            settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween(begin: const Offset(1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }
}
