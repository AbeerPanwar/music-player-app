import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:material_new_shapes/material_new_shapes.dart';

class Loader extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  const Loader({super.key, required this.color, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: ExpressiveLoadingIndicator(
          color: color,

          constraints: const BoxConstraints(
            minWidth: 64.0,
            minHeight: 64.0,
            maxWidth: 64.0,
            maxHeight: 64.0,
          ),

          polygons: [
            MaterialShapes.softBurst,
            MaterialShapes.pentagon,
            MaterialShapes.cookie4Sided,
            MaterialShapes.oval,
          ],
        ),
      ),
    );
  }
}
