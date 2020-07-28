import 'package:cat_app/models/cat_model.dart';
import 'package:cat_app/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class CatCard extends StatefulWidget {
  final Cat cat;

  CatCard(this.cat);

  @override
  _CatCardState createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  // Cat cat; --- this is against best practises because it duplicates the variable

  // A class property that represents the URL flutter will render
  // from the Cat class.
  String renderUrl;

  // _CatCardState(this.cat); --- not needed anymore

  // State classes run this method when the state is created.
  // You shouldn't do async work in initState, so we'll defer it
  // to another method.
  void initState() {
    super.initState();
    renderCatPic();
  }

  // IRL, we'd want the Cat class itself to get the image
  // but this is a simpler way to explain Flutter basics
  void renderCatPic() async {
    // this makes the service call
    await widget.cat.getImageUrl();
    // setState tells Flutter to rerender anything that's been changed.
    // setState cannot be async, so we use a variable that can be overwritten
    if (mounted) {
      // Avoid calling `setState` if the widget is no longer in the widget tree.
      setState(() {
        renderUrl = widget.cat.imageUrl;
      });
    }
  }

  Widget get catImage {
    return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
      width: 80.0,
      height: 80.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
      decoration: BoxDecoration(
        // BoxDecorations have many possible properties.
        // Using BoxShape with a background image is the
        // easiest way to make a circle cropped avatar style image.
        shape: BoxShape.circle,
        image: DecorationImage(
          // Just like CSS's `imagesize` property.
          fit: BoxFit.cover,
          // A NetworkImage widget is a widget that
          // takes a URL to an image.
          // ImageProviders (such as NetworkImage) are ideal
          // when your image needs to be loaded or can change.
          // Use the null check to avoid an error.
          image: NetworkImage(renderUrl ?? 'https://via.placeholder.com/150'),
        ),
      ),
    );
  }

  Widget get catCard {
    // A new container
    // The height and width are arbitrary numbers for styling.
    return Container(
        width: 320.0,
        height: 150.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Card(
            color: Colors.black87,
            // Wrap children in a Padding widget in order to give padding.
            child: Padding(
              // The class that controls padding is called 'EdgeInsets'
              // The EdgeInsets.only constructor is used to set
              // padding explicitly to each side of the child.
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              // Column is another layout widget -- like stack -- that
              // takes a list of widgets as children, and lays the
              // widgets out from top to bottom.
              child: Row(
                children: <Widget>[
                  CircleImage(renderUrl),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      // These alignment properties function exactly like
                      // CSS flexbox properties.
                      // The main axis of a column is the vertical axis,
                      // `MainAxisAlignment.spaceAround` is equivalent of
                      // CSS's 'justify-content: space-around' in a vertically
                      // laid out flexbox.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(widget.cat.name,
                            // Themes are set in the MaterialApp widget at the root of your app.
                            // They have default values -- which we're using because we didn't set our own.
                            // They're great for having consistent, app-wide styling that's easily changed.
                            style: Theme.of(context).textTheme.headline6),
                        Text(widget.cat.location,
                            style: Theme.of(context).textTheme.subtitle2),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                            ),
                            Text(': ${widget.cat.rating} / 10')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 150.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              child: catCard,
            ),
          ],
        ),
      ),
    );
  }
}
