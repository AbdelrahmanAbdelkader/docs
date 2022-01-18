import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/screens/postscreen/posts/widgets/comment.dart';
import 'package:sample/screens/postscreen/posts/widgets/comment_text_field.dart';
import 'package:sample/screens/postscreen/posts/widgets/post_image.dart';
import 'package:sizer/sizer.dart';

enum CommentsType {
  detail,
  undetail,
}

class NormalPost extends StatelessWidget {
  NormalPost({
    Key? key,
    required this.date,
    required this.text,
    required this.volName,
    required this.comments,
    required this.postId,
    this.images,
  }) : super(key: key);
  final String volName;
  final String postId;
  final DateTime date;
  final String text;
  CommentsType comments;
  List? images;

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
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
                                key: UniqueKey(),
                                imagePath: images![0],
                              )
                            : (images!.length == 2)
                                ? Row(
                                    children: images!
                                        .map((e) => Expanded(
                                              flex: 1,
                                              child: PostImage(
                                                key: UniqueKey(),
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
                                                key: UniqueKey(),
                                                imagePath: images![0],
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                PostImage(
                                                  key: UniqueKey(),
                                                  imagePath: images![1],
                                                ),
                                                PostImage(
                                                  key: UniqueKey(),
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
                                                child: Container(
                                                  child:
                                                      Image.asset(images![0]),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child: Image.asset(
                                                            images![1]),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: Image.asset(
                                                            images![2]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        ChangeNotifierProvider.value(
                                          value: account,
                                          child: NormalPost(
                                            comments: CommentsType.detail,
                                            postId: postId,
                                            date: date,
                                            text: text,
                                            volName: text,
                                          ),
                                        )));
                              },
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
                            onPressed: () async {
                              dynamic val = await FirebaseDatabase.instance
                                  .ref()
                                  .child('posts')
                                  .child('seen')
                                  .child(postId)
                                  .child(account.id as String)
                                  .get();
                              if (val.value == null)
                                val = false;
                              else
                                val = val.value;
                              await FirebaseDatabase.instance
                                  .ref()
                                  .child('posts')
                                  .child('seen')
                                  .child(postId)
                                  .child(account.id as String)
                                  .set(!val);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //bool read
                                //(read)?
                                StreamBuilder<DatabaseEvent>(
                                    stream: FirebaseDatabase.instance
                                        .ref()
                                        .child('posts')
                                        .child('seen')
                                        .child(postId)
                                        .child(account.id as String)
                                        .onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        if (snapshot.data!.snapshot.value !=
                                            null) {
                                          if ((snapshot.data!.snapshot.value
                                                  as bool) ==
                                              true) return Icon(Icons.star);
                                        }
                                      }
                                      return Icon(Icons.star_border);
                                    }),
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
            (comments == CommentsType.undetail)
                ? Divider(
                    height: 0,
                  )
                : Container(),
            StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child('posts')
                    .child('comment')
                    .child(postId)
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final Map data = snapshot.data!.snapshot.value as Map;
                    for (int i = 0; i < data.length; i++) {
                      for (int y = i + 1; y < data.length; y++) {
                        if (DateTime.parse((data[i]['date'] as String)).isAfter(
                            DateTime.parse((data[y]['date'] as String)))) {
                          Map temp = data[i];
                          data[i] = data[y];
                          data[y] = temp;
                        }
                      }
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: data.length,
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
                          latest: i == min(data.length - 1, 2),
                          comment: data[i],
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
            CommentTextField(postId),
          ],
        ),
      ),
    );
  }
}
