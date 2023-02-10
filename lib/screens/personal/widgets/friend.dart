import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Friend extends StatelessWidget {
  final String friendName;
  final String imageUrl;

  const Friend({Key? key, required this.friendName, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                child: Container(
                  child: Image(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.fill,
                    // fit: BoxFit.cover
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(friendName,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
