import 'package:flutter/material.dart';

class CustomContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0005833, size.height * 0.3360833);
    path_0.quadraticBezierTo(size.width * 0.0600833, size.height * 0.3322000,
        size.width * 0.0608333, size.height * 0.4194833);
    path_0.quadraticBezierTo(size.width * 0.0608667, size.height * 0.5060667,
        size.width * 0.0019333, size.height * 0.5001000);

    path_0.lineTo(size.width * 0.0000167, size.height);

    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 1.0002750, size.height * 0.5006667);
    path_0.quadraticBezierTo(size.width * 0.9378667, size.height * 0.5054833,
        size.width * 0.9377917, size.height * 0.4183667);
    path_0.quadraticBezierTo(size.width * 0.9407917, size.height * 0.3344500,
        size.width * 1.0010917, size.height * 0.3339333);
    path_0.lineTo(size.width * 1.0021667, size.height * -0.0071333);
    path_0.lineTo(size.width * 0.0025167, size.height * -0.0049167);

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
