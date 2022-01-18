import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/screens/postscreen/posts/widgets/post_image.dart';

class ImportantPost extends StatelessWidget {
  ImportantPost({
    Key? key,
    required this.date,
    required this.text,
    required this.volName,
    this.images,
  }) : super(key: key);
  final String volName;
  final DateTime date;
  final String text;

  List? images;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
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
                                            child: Image.asset(images![0]),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child:
                                                      Image.asset(images![1]),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child:
                                                      Image.asset(images![2]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
