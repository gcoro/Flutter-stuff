import 'package:cat_app/models/cat_model.dart';
import 'package:cat_app/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class CatDetailPage extends StatefulWidget {
  final Cat cat;

  CatDetailPage(this.cat);

  @override
  _CatDetailPageState createState() => _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage> {
  // Arbitrary size choice for styles
  final double avatarSize = 150.0;

  Widget get catImage {
    // Containers define the size of its children.
    return CircleImage(widget.cat.imageUrl, this.avatarSize);
  }

  // The rating section that says ★ 10/10.
  Widget get rating {
    // Use a row to lay out widgets horizontally.
    return Row(
      // Center the widgets on the main-axis
      // which is the horizontal axis in a row.
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 40.0,
        ),
        Text(' ${widget.cat.rating} / 10',
            style: Theme.of(context).textTheme.headline3),
      ],
    );
  }

  // The widget that displays the image, rating and info.
  Widget get catProfile {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        // This would be a great opportunity to create a custom LinearGradient widget
        // that could be shared throughout the app but I'll leave that to you.
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.pink[300],
            Colors.pink[200],
            Colors.pink[100],
            Colors.pink[50],
          ],
        ),
      ),
      // The Profile information.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          catImage,
          Text(
            '${widget.cat.name} 🐈',
            style: TextStyle(fontSize: 36.0),
          ),
          Text(
            widget.cat.location,
            style: TextStyle(fontSize: 25.0),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text(widget.cat.description),
          ),
          rating
        ],
      ),
    );
  }

  //Finally, the build method:
  //
  // Aside:
  // It's often much easier to build UI if you break up your widgets the way I
  // have in this file rather than trying to have one massive build method
  @override
  Widget build(BuildContext context) {
    // This is a new page, so you need a new Scaffold!
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Meet ${widget.cat.name}'),
      ),
      body: catProfile,
    );
  }
}