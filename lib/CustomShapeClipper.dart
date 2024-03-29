import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    // Create a curve
    // Offsets for defining the position
    var firstEndPoint = Offset(size.width * .5 ,size.height - 30.0);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 50.0);
    /// Adds a quadratic bezier segment that curves from the current
    /// point to the given point 'endPoint(x2,y2), using the control point
    /// (x1,y1).
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);


    var secondEndPoint = Offset(size.width, size.height - 80.0);
    var secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;


}