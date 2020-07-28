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
  // This is the starting value of the slider.
  double _sliderValue = 0.0;

  void updateRating() {
    setState(() => widget.cat.rating = _sliderValue.toInt());
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
          CircleImage(widget.cat.imageUrl, this.avatarSize),
          Text(
            '${widget.cat.name} 🐈',
            style: TextStyle(fontSize: 36.0),
          ),
          Text(
            widget.cat.location,
            style: TextStyle(fontSize: 25.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text(widget.cat.description),
          ),
          rating
        ],
      ),
    );
  }

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // In a row, column, listview, etc., a Flexible widget is a wrapper
              // that works much like CSS's flex-grow property.
              //
              // Any room left over in the main axis after
              // the widgets are given their width
              // will be distributed to all the flexible widgets
              // at a ratio based on the flex property you pass in.
              // Because this is the only Flexible widget,
              // it will take up all the extra space.
              //
              // In other words, it will expand as much as it can until
              // the all the space is taken up.
              Flexible(
                flex: 1,
                // A slider, like many form elements, needs to know its
                // own value and how to update that value.
                //
                // The slider will call onChanged whenever the value
                // changes. But it will only repaint when its value property
                // changes in the state using setState.
                //
                // The workflow is:
                // 1. User drags the slider.
                // 2. onChanged is called.
                // 3. The callback in onChanged sets the sliderValue state.
                // 4. Flutter repaints everything that relies on sliderValue,
                // in this case, just the slider at its new value.
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 10.0,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                ),
              ),

              // This is the part that displays the value of the slider.
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.headline4),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  // A simple Raised Button that as of now doesn't do anything yet.
  Widget get submitRatingButton {
    return RaisedButton(
      onPressed: () => updateRating(),
      child: Text('Vote'),
      color: Colors.pinkAccent,
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
      body: ListView(
        children: <Widget>[
          catProfile,
          addYourRating
        ],
      ),
    );
  }
}