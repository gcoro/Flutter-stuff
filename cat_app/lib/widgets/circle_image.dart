import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String renderUrl;

  CircleImage(this.renderUrl);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 100.0,
      height: 100.0,
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