import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// shimmer effect
// class Shimmer extends StatelessWidget {
//   double conHeight;
//   double conWidth;
//   Shimmer({super.key, required this.conHeight, required this.conWidth});

// @override
// Widget build(BuildContext context) {
//   return Container(
//     height: conHeight,
//     width: conWidth,
//     color: Color.fromARGB(255, 240, 245, 249),
//     // color: Colors.grey,
//   );
// }
class ShimmerEffect extends StatelessWidget {
  final double conHeight;
  final double conWidth;

  const ShimmerEffect(
      {super.key, required this.conHeight, required this.conWidth});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 240, 245, 249),
      highlightColor: Colors.white,
      child: Container(
        height: conHeight,
        width: conWidth,
        color: const Color.fromARGB(255, 240, 245, 249),
      ),
    );
  }
}
