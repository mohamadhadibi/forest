import 'package:flutter/material.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}