import 'package:flutter/material.dart';
import 'package:sample/screens/postscreen/posts/widgets/post_image.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({Key? key, required this.tag, required this.images})
      : super(key: key);
  final String tag;
  final List? images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصور'),
        centerTitle: true,
      ),
      body: PageView(
        children: [
          ...images!
              .map(
                (e) => PostImage(
                  key: UniqueKey(),
                  imagePath: e,
                  images: images as List,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
