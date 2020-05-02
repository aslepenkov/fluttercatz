import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifCardWidget extends StatelessWidget {
  final String position;

  const GifCardWidget(
      this.position, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = Image.network(position);
    var cardHeigh = image.height;
    return Container(
        height: cardHeigh,
        child: Card(
            child:image
        )
    );
  }
}