import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/screens/postscreen/posts/widgets/comment.dart';
import 'package:sample/screens/postscreen/posts/widgets/comment_text_field.dart';
import 'package:sample/screens/postscreen/posts/widgets/last_post_image.dart';
import 'package:sample/screens/postscreen/posts/widgets/post_image.dart';
import 'package:sizer/sizer.dart';

class NormalPost extends StatelessWidget {
  NormalPost({
    Key? key,
    required this.date,
    required this.text,
    required this.volName,
    required this.comments,
    this.images,
  }) : super(key: key);
  final String volName;
  final DateTime date;
  final String text;
  List<Map> comments;
  List? images;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      volName,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('hh:mm  d/M/y').format(date),
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      '$text',
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                    (images != null)
                        ? (images!.length == 1)
                            ? PostImage(
                                imagePath: images![0],
                              )
                            : (images!.length == 2)
                                ? Row(
                                    children: images!
                                        .map((e) => Expanded(
                                              flex: 1,
                                              child: PostImage(
                                                imagePath: e,
                                              ),
                                            ))
                                        .toList(),
                                  )
                                : (images!.length == 3)
                                    ? Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: PostImage(
                                                imagePath: images![0],
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                PostImage(
                                                  imagePath: images![1],
                                                ),
                                                PostImage(
                                                  imagePath: images![2],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : (images!.length > 3)
                                        ? Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: PostImage(
                                                    imagePath: images![0],
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: [
                                                    PostImage(
                                                      imagePath: images![1],
                                                    ),
                                                    LastPostImage(
                                                      important: false,
                                                      images: images,
                                                      imagePath: images![2],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        : Container()
                        : Container(),
                    Divider(),
                    Container(
                      height: 5.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white.withOpacity(0),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('كومنت'),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Icon(Icons.message),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(),
                          Expanded(
                              child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //bool read
                                //(read)?
                                Icon(Icons.star_border),
                                //:Icon(Icons.star),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text('قرأت'),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (comments.isNotEmpty)
                ? Divider(
                    height: 0,
                  )
                : Container(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              itemCount: (comments.length > 2) ? 3 : comments.length,
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Comment(
                  latest: i == comments.length - 1,
                  comment: comments[i],
                ),
              ),
            ),
            CommentTextField(),
          ],
        ),
      ),
    );
  }
}
