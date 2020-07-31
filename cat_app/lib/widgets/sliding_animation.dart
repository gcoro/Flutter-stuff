import 'package:flutter/material.dart';

class SlidingAnimation extends StatefulWidget {
  @override
  _SlidingAnimationState createState() => _SlidingAnimationState();
}

class _SlidingAnimationState extends State<SlidingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _myAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _myAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () => _controller.forward(),
      child: SlideTransition(
        position: _myAnimation,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/images/cat2.png')),
        ),
      ),
    ));
  }
}
