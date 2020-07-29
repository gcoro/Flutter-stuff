import 'package:cat_app/models/cat.dart';
import 'package:flutter/material.dart';

import 'cat_card.dart';

class CatList extends StatelessWidget {
  // Builder methods rely on a set of data, such as a list.
  final List<Cat> cats;

  CatList(this.cats);

  // First, make your build method like normal.
  // Instead of returning Widgets, return a method that returns widgets.
  // Don't forget to pass in the context!
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildList(context),
    );
  }

  // A builder method almost always returns a ListView.
  // A ListView is a widget similar to Column or Row.
  // It knows whether it needs to be scrollable or not.
  // It has a constructor called builder, which it knows will
  // work with a List.

  ListView _buildList(context) {
    return ListView.builder(
      // Must have an item count equal to the number of items!
      itemCount: cats.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      // A callback that will return a widget.
      itemBuilder: (context, int) {
        return Center(
          child: CatCard(cats[int]),
        );
      },
    );
  }
}
