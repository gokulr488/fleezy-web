import 'package:flutter/material.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({required this.children, this.crossAxisCount});
  final List<Widget> children;
  final int? crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: crossAxisCount ?? 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: children),
    );
  }
}
