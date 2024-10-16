// import 'package:flutter/material.dart';

// class ConcaveShape extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final concaveDepth = 20.0; // Controls how deep the concave shape is

//     // Start from the top-left corner
//     // path.moveTo(0, 0);
    
//     // // Top-left to top-right (with concave)
//     // path.lineTo(size.width * 0.5 - concaveDepth, 0);
//     // path.quadraticBezierTo(
//     //   size.width * 0.5, 
//     //   concaveDepth, 
//     //   size.width * 0.5 + concaveDepth, 
//     //   0,
//     // );
//     // path.lineTo(size.width, 0);

//     // Move from top-right to bottom-right
//     // path.lineTo(size.width, size.height * 0.5 - concaveDepth);
//     // path.quadraticBezierTo(
//     //   size.width - concaveDepth, 
//     //   size.height * 0.5, 
//     //   size.width, 
//     //   size.height * 0.5 + concaveDepth,
//     // );
    
//     // Move from bottom-right to bottom-left (with concave)
//     // path.lineTo(size.width * 0.5 + concaveDepth, size.height);
//     // path.quadraticBezierTo(
//     //   size.width * 0.5, 
//     //   size.height - concaveDepth, 
//     //   size.width * 0.5 - concaveDepth, 
//     //   size.height,
//     // );
//     // path.lineTo(0, size.height);

//     // Move from bottom-left to top-left (with concave)
//     // path.lineTo(0, size.height * 0.5 + concaveDepth);
//     // path.quadraticBezierTo(
//     //   concaveDepth, 
//     //   size.height * 0.5, 
//     //   0, 
//     //   size.height * 0.5 - concaveDepth,
//     // );

//     path.close(); // Complete the path

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false; // Return true if you want to redraw the shape when updated
//   }
// }