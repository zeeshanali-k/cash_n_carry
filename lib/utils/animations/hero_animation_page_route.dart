import 'package:flutter/material.dart';

class HeroAnimationPageRoute extends PageRouteBuilder {
  final Widget child;

  HeroAnimationPageRoute({required this.child, required RouteSettings settings})
      : super(
            pageBuilder: (c, a, ac) => child,
            transitionDuration: const Duration(milliseconds: 300),
            settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset.zero).animate(animation),
      child: child,
    );
  }
}
