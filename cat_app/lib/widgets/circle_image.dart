import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String renderUrl;
  final double dimension;

  CircleImage(this.renderUrl, this.dimension);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: dimension ?? 100.0,
      height: dimension ?? 100.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(renderUrl ?? 'https://via.placeholder.com/150'),
        ),
      ),
    );
  }
}