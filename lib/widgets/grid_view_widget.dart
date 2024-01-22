import 'package:flutter/material.dart';
class GridViewBuilder extends StatelessWidget {
  final double aspectRatio;
  final int itemCount;
  final int crossAxisCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  const GridViewBuilder({super.key, 
    required this.aspectRatio, 
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          itemCount: itemCount,
          // shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            // crossAxisSpacing: 7,
            // mainAxisSpacing: 7
            ), 
          itemBuilder: itemBuilder
        ),
      ),
    );
  }
}