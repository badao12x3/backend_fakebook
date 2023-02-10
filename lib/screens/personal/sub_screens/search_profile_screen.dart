import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/screens/personal/widgets/personal_widgets.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';

class SearchProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: SearchBar(),
        titleSpacing: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(

          ),
        ],
      ),
    );
  }
}
