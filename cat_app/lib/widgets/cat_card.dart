import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/cat_detail_page.dart';
import 'package:cat_app/widgets/circle_image.dart';
import 'package:flutter/material.dart';

class CatCard extends StatefulWidget {
  Cat cat;

  CatCard(this.cat);

  @override
  _CatCardState createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  // Cat cat; --- this is against best practises because it duplicates the variable

  // _CatCardState(this.cat); --- not needed anymore

  // This is the builder method that creates a new page.
  showDetailPage() async {
    // Navigator.of(context) accesses the current app's navigator.
    // Navigators can 'push' new routes onto the stack,
    // as well as pop routes off the stack.
    //
    // This is the easiest way to build a new page on the fly
    // and pass that page some state from the current page.

    Cat updatedCat = await Navigator.of(context).push(
      MaterialPageRoute(
        // builder methods always take context!
        builder: (context) {
          return CatDetailPage(widget.cat);
        },
      ),
    );

    if (updatedCat != null) {
      setState(() => widget.cat = updatedCat);
    }
  }

  Widget get catImage {
    // Wrap the dogAvatar widget in a Hero widget.
    return Hero(
        // Give your hero a tag.
        //
        // Flutter looks for two widgets on two different pages,
        // and if they have the same tag it animates between them.
        tag: widget.cat,
        child: CircleImage(widget.cat.imageUrl, 100));
  }

  Widget get catCard {
    // A new container
    // The height and width are arbitrary numbers for styling.
    return Container(
        // width: 320.0,
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
                  catImage,
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
    // InkWell is a special Material widget that makes its children tappable
    // and adds Material Design ink ripple when tapped.
    return InkWell(
      onTap: showDetailPage,
      child: Padding(
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
      ),
    );
  }
}
