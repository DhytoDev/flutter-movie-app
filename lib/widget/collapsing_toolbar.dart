import 'package:flutter/material.dart';
import 'package:flutter_movie_app/widget/my_text_styles.dart';

class CollapsingToolbar extends StatelessWidget {
  final double _appBarHeight = 256.0;
  final String title, backdrop;

  CollapsingToolbar({this.title, this.backdrop});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _appBarHeight,
      pinned: true,
      title: text(title, color: Colors.white, size: 18.0),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: title,
              child: Image.network(
                backdrop,
                fit: BoxFit.cover,
                height: _appBarHeight,
              ),
            ),
            const DecoratedBox(
              decoration: const BoxDecoration(
                gradient: const LinearGradient(
                  begin: const Alignment(0.0, -1.0),
                  end: const Alignment(0.0, -0.4),
                  colors: const <Color>[
                    const Color(0x60000000),
                    const Color(0x00000000)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
