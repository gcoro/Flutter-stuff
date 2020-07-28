import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String renderUrl;
  final double dimension;

  CircleImage(this.renderUrl, this.dimension);

  @override
  Widget build(BuildContext context) {
    // Placeholder is a static container the same size as the dog image.
    var placeholder = Container(
      width:  dimension ?? 100.0,
      height:  dimension ?? 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'CAT!',
        textAlign: TextAlign.center,
      ),
    );

    var avatar = Container(
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

    // This is an animated widget built into flutter.
    return AnimatedCrossFade(
      // You pass it the starting widget and the ending widget.
      firstChild: placeholder,
      secondChild: avatar,
      // Then, you pass it a ternary that should be based on your state
      //
      // If renderUrl is null tell the widget to use the placeholder,
      // otherwise use the dogAvatar.
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      // Finally, pass in the amount of time the fade should take.
      duration: Duration(milliseconds: 1000),
    );
  }
}