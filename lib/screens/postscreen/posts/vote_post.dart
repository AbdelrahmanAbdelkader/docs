import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VotePost extends StatefulWidget {
  const VotePost({
    Key? key,
    required this.votes,
    required this.totalVotes,
    required this.volName,
    required this.date,
    required this.text,
  }) : super(key: key);
  final List<Map> votes;
  final int totalVotes;
  final String volName;
  final DateTime date;
  final String text;
  @override
  State<VotePost> createState() => _VotePostState();
}

class _VotePostState extends State<VotePost> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.volName,
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      Text(
        DateFormat('hh:mm  dd/MM/yyyy').format(widget.date),
        style: TextStyle(color: Colors.grey[400]),
      ),
      Text(widget.text),
      ...widget.votes
          .map(
            (e) => Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      e['voteName'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: e['quantity'],
                              child: Container(
                                color: Colors.green.withOpacity(.3),
                                height: size.height * .06,
                              ),
                            ),
                            Expanded(
                              flex: (widget.totalVotes - e['quantity'] as int),
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: GestureDetector(
                            child: IconButton(
                              splashRadius: 1.0,
                              iconSize: 16,
                              icon: (e['selected'])
                                  ? Icon(
                                      Icons.check_box,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.green,
                                    ),
                              onPressed: () {
                                setState(() {
                                  e['selected'] = !e['selected'];
                                  if (e['selected'] == true)
                                    e['quantity']++;
                                  else
                                    e['quantity']--;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ]);
  }
}
