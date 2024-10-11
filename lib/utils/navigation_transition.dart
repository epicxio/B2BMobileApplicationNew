import 'package:flutter/material.dart';

class NavigationTransition extends PageRouteBuilder {
  final Widget page;
  NavigationTransition(this.page)
      : super(
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secanimation,
                Widget child) {
              var trans =
                  CurvedAnimation(parent: animation, curve: Curves.ease);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(trans),
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secanimation) {
              return page;
            });
}
